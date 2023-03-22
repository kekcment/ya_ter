pipeline {
    agent any
    // environment {
    //     YC_ACCOUNT_KEY_FILE = credentials('YC_ACCOUNT_KEY_FILE')
    //     YC_FOLDER_ID = credentials('YC_FOLDER_ID')
    //     YC_SUBNET_ID = credentials('YC_SUBNET_ID')
    // }
   
     stages {
        stage('get project') {
            steps {
                echo 'git clone'
                git 'https://github.com/kekcment/yatest1.git'
            }
        }

        stage('test terraform run') {
            steps {
                //sh 'cd tf configs/build_tf/'
                sh 'terraform -chdir=build_tf/ init'
                sh 'terraform -chdir=build_tf/ plan'
                sh 'terraform -chdir=build_tf/ apply -auto-approve'
            }
        }

        // stage('test playbook run') {
        //     steps {
        //         sh 'ansible-playbook -i /tmp/test1 --user=ubuntu --private-key=~/.ssh/build_key ansbl/ansbl_build/build.yml'
        //     }
        // }
}
}