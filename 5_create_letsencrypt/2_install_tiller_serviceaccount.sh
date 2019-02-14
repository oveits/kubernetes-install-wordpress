
if ! kubectl get -n kube-system ServiceAccount | grep "^NAME\|tiller"; then
  echo installing serviceaccount for tiller
  
  cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EOF

  [ "$?" == "0" ] \
    && echo re-running helm init with service-account tiller \
    && helm init --service-account tiller --upgrade
fi
