

if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; bash $0"
  exit 1
fi

cat <<EOF > certificate.yaml
---
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: vocon-it-com-staging
  namespace: ${NAMESPACE}
spec:
  secretName: vocon-it-com-staging-tls
  issuerRef:
    name: letsencrypt-staging-dns
  commonName: '*.vocon-it.com'
  dnsNames:
  - vocon-it.com
  acme:
    config:
    - dns01:
        provider: cloudflare
      domains:
      - '*.vocon-it.com'
      - vocon-it.com
EOF

[ "$?" == "0" ] && \
kubectl apply -f certificate.yaml

