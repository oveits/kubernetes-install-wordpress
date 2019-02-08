
if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; bash $0"
  exit 1
fi

#kubectl get issuer -n ${NAMESPACE} | grep -q letsencrypt-staging-dns
#
#[ "$?" == "0" ] || \
cat <<EOF > issuer-staging-dns.yaml
---
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: letsencrypt-staging-dns
  namespace: ${NAMESPACE}
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: oliver.veits+letsencrypt-dns-cloudflare-test@vocon-it.com
    privateKeySecretRef:
      name: letsencrypt-staging-dns
    dns01:
      providers: cloudflare
      cloudflare:
        email: oliver.veits@vocon-it.com
        apiKeySecretRef:
              name: cloudflare-api-key
              key: cloudflare-api-key.txt
EOF

[ "$?" == "0" ] && \
kubectl apply -f issuer-staging-dns.yaml
