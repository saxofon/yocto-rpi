/* Define this in jenkins as :

   Create job :
   name : yocto-rpi
   type : pipeline

   Pipeline :
   Pipeline script from SCM
   SCM : git
   URL : https://gitlab.pstraining3.wrstudio1.cloud/phallsma/yocto-rpi.git
   Branch : topic/jenkins-kubernetes-pipelines
   Script path : pipelines/yocto-build-kubernetes.groovy
*/

pipeline {
	agent {
		kubernetes {
			idleMinutes 5
			yamlFile 'pipelines/yocto-build-pod.yaml'
			defaultContainer 'yocto-builder'
		}
	}

	parameters {
		string(
			name: 'GIT_REPO',
			defaultValue: 'https://gitlab.pstraining3.wrstudio1.cloud/phallsma/yocto-rpi.git',
			description: 'URL of git repo to build'
		)
		string(
			name: 'BRANCH',
			defaultValue: 'topic/jenkins-kubernetes-pipelines',
			description: 'Add branch to build'
		)
		booleanParam(
			name: 'SCRATCH_BUILD',
			defaultValue: false,
			description: 'Rebuild from scratch'
		)
		booleanParam(
			name: 'CACHE_BUILD',
			defaultValue: false,
			description: 'Rebuild from cache'
		)
		booleanParam(
			name: 'SSTATE_UPDATE',
			defaultValue: true,
			description: 'Update sstate cache after sucessful build'
		)
	}

	stages {
		stage("Git clone project") {
			steps {
				git branch: "${params.BRANCH}", url: "${params.GIT_REPO}"
			}
		}
		stage("Clean out build AND caches") {
			when {
				expression {
					params.SCRATCH_BUILD == true
				}
			}
			steps {
				sh "make distclean"
			}
		}
		stage("Clean out build") {
			when {
				expression {
					params.CACHE_BUILD == true
				}
			}
			steps {
				sh "make clean"
			}
		}
		stage("Debug") {
			steps {
				script {
					sh "cat /proc/cpuinfo | sort | uniq"
					sh "nproc"
					sh "lscpu"
					sh "free -h"
					sh "pwd"
					sh "ls cache/*"
				}
			}
		}
		stage("Build images") {
			steps {
				sh "make images"
			}
		}
		stage("Update sstate cache") {
			when {
				expression {
					params.SSTATE_UPDATE == true
				}
			}
			steps {
				sh "make sstate-update"
			}
		}
		
	}
}
