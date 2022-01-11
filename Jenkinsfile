
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
				sshCommand remote: remote, command: 'id && rm -rf admin-dashboard-php && git clone https://github.com/tagost/admin-dashboard-php.git'
				sshCommand remote: remote, command: "cd admin-dashboard-php && docker build -t tagost/admin-php ."
			}
			stage ('Docker push'){
				sshCommand remote: remote, command: 'docker push tagost/admin-php'
			}
			/*stage ('Deploy aplication'){
				sshCommand remote: remote, command: 'docker rm -fv admin'
				sshCommand remote: remote, command: "cd admin-dashboard-php && docker-compose up -d"
			}*/
			stage ('Deploy aplication'){
				sshCommand remote: remote, command: 'helm repo add --force-update admin-php  https://tagost.github.io/helmcharts/ && helm uninstall admin && sleep 3'
				sshCommand remote: remote, command: "helm install admin admin-php/admin-php"
			}
		}		
	}
}
