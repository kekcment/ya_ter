pipeline {
    agent {
    docker {
        image 'kekcment/jdk-plus:0.1.0'
        args '--privileged -v /var/run/docker.sock:/var/run/docker.sock -u root'
    }
  }   

     stages{ 
      
      stage('Copy source from git') {
        steps {
            echo 'git clone'
            sh 'cd /tmp/'
            git 'https://github.com/kekcment/ya_ter.git'
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

        stage('test playbook run') {
            steps {
                sh 'ansible-playbook -i /tmp/test1 --user=ubuntu --private-key=~/.ssh/build_key ansbl/ansbl_build/build.yml'
            }
        }
}
}