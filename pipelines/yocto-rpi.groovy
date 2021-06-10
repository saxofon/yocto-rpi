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
			image 'yocto-builder:0.1'
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
	}

	stages {
		stage("Git clone yocto-rpi project layer") {
			steps {
				git branch: "${params.BRANCH}", url: 'https://github.com/saxofon/yocto-rpi.git'
			}
		}
		stage("Build images") {
			steps {
				sh "make images"
			}
		}
		
	}
}
