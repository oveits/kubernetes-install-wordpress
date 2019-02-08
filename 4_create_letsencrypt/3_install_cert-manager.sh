
# install cert-manager, if  not already done:
kubectl get crd | grep -q issuers.certmanager.k8s.io \
  || helm install \
       --name cert-manager \
       --namespace kube-system \
       stable/cert-manager

