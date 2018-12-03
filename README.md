
## Dependencies
- https://www.terraform.io/docs/providers/google/getting_started.html
- https://github.com/terraform-providers/terraform-provider-helm
- https://github.com/helm/charts/tree/master/stable/jenkins

## Setup GCP CLI to Support Terraform Google Provider
```bash
export GOOGLE_APPLICATION_CREDENTIALS=~/source/ignw-internal-tools-4baa9a408443.json
export GOOGLE_PROJECT=ignw-internal-tools
export GOOGLE_REGION=uswest-1
export GOOGLE_ZONE=us-west1-b
```
OR RUN `source gcp.env` after replacing `GOOGLE_APPLICATION_CREDENTIALS` with your service account credentials file.
```bash
source gcp.env
env | grep GOOGLE

phil-macbook:terraform-gcp-cicd-demo Phil$ env | grep GOOGLE
GOOGLE_APPLICATION_CREDENTIALS=/Users/Phil/source/ignw-internal-tools-4baa9a408443.json
GOOGLE_REGION=uswest-1
GOOGLE_ZONE=us-west1-b
GOOGLE_PROJECT=ignw-internal-tools
```




## Deploying the CI/CD Environment w/ Terraform
The following example will bring up a new GKE cluster and then deploy the CI/CD environment components on top of it using HELM.
- Google K8S Cluster (GKE)
- Jenkins
- Sonar Qube

Example Deployment
```bash
terraform init
terraform plan -var-file=example.tfvars
terraform apply -var-file=example.tfvars
```


## Manually Fix GKE Service Account Credentials & Bootstrap HELM 
```
tf init
tf apply -auto-approve

gcloud container clusters get-credentials elkdemo --zone us-central1-c --project ignw-internal-tools

helm init

#### Service account needed with GKE
kubectl create serviceaccount --namespace kube-system tiller

kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

helm init --upgrade
helm repo update
helm install --name elkdemo stable/elastic-stack

# use port forward to get to the stack up local
# for example 
kubectl port-forward <pod_name> <kubeport>:<localport>
```