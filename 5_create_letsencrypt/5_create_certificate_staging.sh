
# if NAMESPACE is not defined, use the current namespace:
[ "$NAMESPACE" == "" ] \
  && NAMESPACE=$(kubectl config get-contexts | grep '^\*' | awk '{print $5}')

# if current NAMESPACE is not defined, use the default namespace:
[ "$NAMESPACE" == "" ] && NAMESPACE=default

[ "$1" == "-d" ] && CMD=delete || CMD=apply

cat <<EOF | kubectl $CMD -f -
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
  #commonName: 'vocon-it.com'
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


