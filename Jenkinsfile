pipeline {
    agent any


     stages {
        stage('get project') {
            steps {
                echo 'git clone'
                git 'https://github.com/kekcment/yatest1.git'
            }
        }

        stage('test terraform run') {
            steps {
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