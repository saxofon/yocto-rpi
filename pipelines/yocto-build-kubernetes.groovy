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
			yamlFile 'pipelines/yocto-build-pod.yaml'
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
		stage("debug") {
			steps {
				script {
					sh "printenv"
				}
			}
		}
		stage("Prepare for artifacts handling") {
			when {
				expression {
					env.INTERNAL_ARTIFACTS_HTTP != null
				}
			}
			steps {
				script {
					sh "sudo mkdir -p ~/.mc"
					sh "sudo chmod 777 ~/.mc"
					sh "wget https://dl.min.io/client/mc/release/linux-amd64/mc"
					sh "chmod +x mc"
					withCredentials([usernamePassword(credentialsId: 'artifacts-credentials', usernameVariable: 'MINIO_ACCESS_KEY', passwordVariable: 'MINIO_SECRET_KEY')]) {
						sh './mc config host add minio \"${INTERNAL_ARTIFACTS_HTTP}\" \"${MINIO_ACCESS_KEY}\" \"${MINIO_SECRET_KEY}\"'
					}
				}
			}
		}
		stage("Arrange permissions for cache") {
			steps {
				script {
					sh "sudo mkdir -p /cache"
					sh "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport phallsma-g4-storage:/  /cache"
					sh "sudo chmod 777 /cache"
				}
			}
		}
		stage("prebuild workaround for cache storage") {
			when {
				allOf {
					expression {
						env.INTERNAL_ARTIFACTS_HTTP != null
					}
					expression {
						params.PARAM5 != null
					}
					expression { false }
				}
			}
			steps {
				script {
					//sh "./mc cp --quiet --recursive minio/${params.PARAM5}/cache / || true"
					//sh "ls /cache"
					//sh "ls /cache/downloads || true"
					//sh "ls /cache/sstate-mirror || true"
					sh "./mc cp --quiet --recursive minio/${params.PARAM5}/cache.tar /tmp || true"
					sh "tar -C /cache -xf /tmp/cache.tar || true"
				}
			}
		}
		stage("Git clone project") {
			when { expression { false } }
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
			when { expression { false } }
			steps {
				sh "make images"
			}
		}
		stage("Update sstate cache") {
			when { expression { false } }
			when {
				expression {
					params.SSTATE_UPDATE == true
				}
			}
			steps {
				sh "make sstate-update"
			}
		}
		stage("postbuild workaround for cache storage") {
			when {
				allOf {
					expression {
						env.INTERNAL_ARTIFACTS_HTTP != null
					}
					expression {
						params.PARAM5 != null
					}
					expression { false }
				}
			}
			steps {
				script {
					//sh "./mc cp --quiet --recursive /cache minio/${params.PARAM5} || true"
					//sh "./mc ls minio/${params.PARAM5} || true"
					//sh "./mc ls minio/${params.PARAM5}/cache || true"
					//sh "./mc ls minio/${params.PARAM5}/cache/downloads || true"
					//sh "./mc ls minio/${params.PARAM5}/cache/sstate-mirror || true"
					sh "tar -C /cache -cf /tmp/cache.tar ."
					sh "./mc cp --quiet /tmp/cache.tar minio/${params.PARAM5} || true"
				}
			}
		}
		stage("Store artifacts") {
			when {
				allOf {
					expression {
						env.INTERNAL_ARTIFACTS_HTTP != null
					}
					expression {
						params.PARAM5 != null
					}
					expression { false }
				}
			}
			steps {
				script {
					sh "du -sh build"
					sh "du -sh build/build/tmp/deploy/images/raspberrypi4-64"
					sh "ls build/build/tmp/deploy/images/raspberrypi4-64"
					sh "./mc mb minio/${params.PARAM5}/${BUILD_NUMBER}"
					sh "./mc cp build/build/tmp/deploy/images/raspberrypi4-64/Image minio/${params.PARAM5}/${BUILD_NUMBER}"
					sh "./mc cp build/build/tmp/deploy/images/raspberrypi4-64/bcm2711-rpi-4-b.dtb minio/${params.PARAM5}/${BUILD_NUMBER}"
					sh "./mc cp build/build/tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.wic minio/${params.PARAM5}/${BUILD_NUMBER}"
				}
			}
		}
		stage("Return to PLM") {
			when {
				expression {
					params.PARAM5 != null
				}
			}
			steps {
				script {
					print """BEGIN OUTPUT{"output1": "Image", "artifactPath": "${params.PARAM5}/${BUILD_NUMBER}/"}END OUTPUT"""
				}
			}
		}
	}
}
