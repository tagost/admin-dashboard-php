
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
				sshCommand remote: remote, command: 'rm -rf admin-dashboard-php && git clone https://github.com/tagost/admin-dashboard-php.git'
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
				sshCommand remote: remote, command: '(helm repo add admin-php https://github.com/tagost/helmcharts 2> /dev/null || true) && helm uninstall admin && sleep 3'
				sshCommand remote: remote, command: "helm install admin admin-php/admin-php"
			}
		}		
	}
}
