
source $CONFIG_FILE
[ "$1" == "-d" ] && CMD=delete || CMD=apply

cat << EOF | kubectl $CMD -f -
---
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: letsencrypt-staging
  namespace: ${NAMESPACE}
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: issuer-letsencrypt-staging@vocon-it.com
    privateKeySecretRef:
      name: letsencrypt-staging
    http01: {}
EOF

