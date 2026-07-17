pipeline {
agent any
environment {
AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
AWS_DEFAULT_REGION = 'us-east-1'
// Ubuntu terraform path
PATH = "/usr/bin:${env.PATH}"
}
options {
ansiColor('xterm')
timestamps()
timeout(time: 30, unit: 'MINUTES')
disableConcurrentBuilds()
}
stages {
stage('Checkout') {
steps {
checkout scm
sh 'echo "Branch: $GIT_BRANCH | Commit: $GIT_COMMIT"'
}
}
stage('Tool Versions') {
steps {
// Verify tools are available on Ubuntu Jenkins
sh '''
echo "=== Checking tool versions ==="
terraform --version
aws --version
echo "All tools ready!"
'''
}
}
stage('Terraform Init') {
steps {
sh '''
echo "=== Initializing Terraform ==="
terraform init
'''
}
}
stage('Terraform Validate') {
steps {
sh '''
echo "=== Validating Terraform code ==="
terraform validate
echo "Validation passed!"
'''
}
}
stage('Terraform Format Check') {
steps {
// Ubuntu has full terraform fmt support
sh '''
echo "=== Checking Terraform formatting ==="
terraform fmt -check -recursive || \
(echo "Run terraform fmt to fix formatting" && exit 1)
'''
}
}
stage('Terraform Plan') {
steps {
sh '''
echo "=== Running Terraform Plan ==="
terraform plan \
-out=tfplan \
-input=false \
-no-color 2>&1 | tee plan_output.txt
'''
}
post {
always {
archiveArtifacts artifacts: 'tfplan,plan_output.txt',
fingerprint: true
}
}
}
stage('Approval') {
when {
branch 'main'
}
steps {
// Show plan summary before approval
sh 'cat plan_output.txt | grep -E "Plan:|No changes"'
timeout(time: 15, unit: 'MINUTES') {
input message: 'Review the plan above. Approve to deploy to AWS?',
ok: 'Deploy to AWS'
}
}
}
stage('Terraform Apply') {
when {
branch 'main'
}
steps {
sh '''
echo "=== Applying Terraform ==="
terraform apply \
-input=false \
-no-color \
tfplan
echo "=== Deployment Outputs ==="
terraform output
'''
}
}
}
post {
success {
echo '✅ Pipeline succeeded! EC2 deployed by Jenkins on Ubuntu.'
}
failure {
echo '❌ Pipeline failed! Check the logs above for details.'
sh 'terraform show -no-color 2>/dev/null || true'
}
always {
// Ubuntu: clean up plan files
sh 'rm -f tfplan plan_output.txt 2>/dev/null || true'
cleanWs()
}
}
}