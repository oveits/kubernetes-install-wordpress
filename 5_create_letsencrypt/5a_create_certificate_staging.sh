
source $CONFIG_FILE
[ "$1" == "-d" ] && CMD=delete || CMD=apply

cat << EOF | kubectl $CMD -f -
---
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: vocon-it-com-staging
  namespace: ${NAMESPACE}
spec:
  secretName: vocon-it-com-staging-tls
  issuerRef:
    name: letsencrypt-staging
  #commonName: '*.vocon-it.com'
  commonName: '${BOX}.vocon-it.com'
  dnsNames:
  - ${BOX}.vocon-it.com
  acme:
    config:
    - http01:
# TODO: rename ingress "wordpress" -> "ingress" everywhere
        ingress: wordpress
      domains:
      - ${BOX}.vocon-it.com
EOF


