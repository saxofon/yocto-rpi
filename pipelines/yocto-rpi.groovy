/* Define this in jenkins as :

   Create job :
   name : yocto-rpi
   type : pipeline

   Pipeline :
   Pipeline script from SCM
   SCM : git
   URL : https://github.com/saxofon/yocto-rpi.git
   Branch : master
   Script path : pipelines/yocto-rpi.groovy
*/

pipeline {
	agent {
		docker {
			image 'docker.io/saxofon/yocto-builder:0.6'
			args '--name=yocto-builder'
			args '-v /var/jenkins_home:/var/jenkins_home:Z'
			args '--entrypoint=""'
		/*	reuseNode true */
		}
	}

	options {
		disableConcurrentBuilds()
		timestamps()
	}

	parameters {
		string(
			name: 'BRANCH',
			defaultValue: 'master',
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
		stage("Git clone yocto-rpi project layer") {
			steps {
				git branch: "${params.BRANCH}", url: 'https://github.com/saxofon/yocto-rpi.git'
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
