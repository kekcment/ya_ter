pipeline {
    agent any


     stages {
        stage('get project') {
            steps {
                echo 'git clone'
                git 'https://github.com/kekcment/ya_ter.git'
            }
        }

        stage('test terraform run') {
            steps {
                sh 'terraform -chdir=build_tf/ init'
                sh 'terraform -chdir=build_tf/ plan'
                sh 'terraform -chdir=build_tf/ apply -auto-approve'
            }
        }

        // stage('connect to vm ') {
        //     steps {
        //         sh 'ansible-playbook -i /tmp/test1 --user=ubuntu --private-key=~/.ssh/build_key ansbl/ansbl_build/build.yml'
        //     }
        // }
}
}