/* Define this in jenkins as :

   Create job :
   name : yocto-rpi
   type : pipeline

   Pipeline :
   Pipeline script from SCM
   SCM : git
   URL : https://gitlab.training-aws.wrstudio.cloud/phallsma/yocto-rpi.git
   URL : https://gitlab.pstraining3.wrstudio1.cloud/phallsma/yocto-rpi.git
   URL : https://github.com/saxofon/yocto-rpi.git
   Branch : topic/jenkins-kubernetes-pipelines
   Script path : pipelines/yocto-build-kubernetes.groovy
*/

pipeline {
	agent {
		kubernetes {
			yamlFile 'pipelines/yocto-build-pod-nonvolatile-storage.yaml'
			defaultContainer 'yocto-builder'
		}
	}

	parameters {
		// a bunch of WR Studio needed parameters named PARAMx
		text(name: "PARAM1") // placeholder
		text(name: "PARAM2") // placeholder
		text(name: "PARAM3") // placeholder
		text(name: "PARAM4") // placeholder
		text(name: "PARAM5") // artifact path
		string(
			name: 'GIT_REPO',
			defaultValue: 'https://github.com/saxofon/yocto-rpi.git',
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
		stage("Debug") {
			steps {
				script {
					sh "du -sh /data"
					sh "ls /data"
				}
			}
		}
		stage("Setup minio client for artifact handling") {
			when {
				expression {
					env.MINIO_URL != null
				}
			}
			steps {
				script {
					sh "sudo mkdir -p ~/.mc"
					sh "sudo chmod 777 ~/.mc"
					sh "wget https://dl.min.io/client/mc/release/linux-amd64/mc"
					sh "chmod +x mc"
					sh "./mc config host add minio \"${env.MINIO_URL}\" \"${env.MINIO_ACCESS_KEY}\" \"${env.MINIO_SECRET_KEY}\""
				}
			}
		}
		stage("Arrange permissions for cache") {
			steps {
				script {
					sh "sudo mkdir -p /cache"
					sh "sudo chmod 777 /cache"
					sh "df -h /cache"
				}
			}
		}
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
		stage("Store artifacts") {
			when {
				expression {
					env.MINIO_URL != null
				}
			}
			steps {
				sh "du -sh build"
				sh "du -sh build/build/tmp/deploy/images/raspberrypi4-64"
				sh "./mc mkdir minio/${params.PARAM5}/${BUILD_NUMBER}"
				sh "./mc cp --recursive build/build/tmp/deploy/images/raspberrypi4-64/ minio/${params.PARAM5}/${BUILD_NUMBER}"
			}
		}
		stage("Return to PLM") {
			steps {
				script {
					print """BEGIN OUTPUT{"output1": "build/build/tmp/deploy/images/raspberrypi4-64/", "artifactPath": "${params.PARAM5}/${BUILD_NUMBER}/"}END OUTPUT"""
				}
			}
		}
	}
}
