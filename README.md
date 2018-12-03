
## Dependencies
- https://www.terraform.io/docs/providers/google/getting_started.html
- https://github.com/terraform-providers/terraform-provider-helm
- https://github.com/helm/charts/tree/master/stable/jenkins



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