
def remote = [:]
remote.name = "k3s"
remote.host = "192.168.0.5"
remote.allowAnyHosts = true
node {
	withCredentials([sshUserPrivateKey(credentialsId: 'k3s-server', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
		remote.user = userName
		remote.identityFile = identity
		withEnv(["DIR=${env.WORKSPACE}"]){
			stage('Build docker image') {
				sshCommand remote: remote, command: 'rm -rf admin-dashboard-php && git clone https://github.com/tagost/admin-dashboard-php.git && cd admin-dashboard-php'
				sshCommand remote: remote, command: "docker build -t tagost/admin-php ."
			}
			/*stage ('Docker push'){
				sshCommand remote: remote, command: 'docker push tagost/admin-php'
			}*/
			stage ('Deploy aplication'){
				sshCommand remote: remote, command: 'docker rm -fv admin-php'
				sshCommand remote: remote, command: "cd admin-php/\"${env.JOB_NAME}\" && docker-compose up -d"
			}
		}		
	}
}
