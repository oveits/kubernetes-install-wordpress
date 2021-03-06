

kubectl get issuer | grep -q letsencrypt-staging

[ "$?" == "0" ] || \
cat <<EOF > issuer-staging.yaml
---
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: oliver.veits+letsencrypt-test@vocon-it.com
    privateKeySecretRef:
      name: letsencrypt-staging
    http01: {}
EOF

[ "$?" == "0" ] && \
kubectl apply -f issuer-staging.yaml
