
source 0_source_set_namespace_and_cmd.sh

cat <<EOF | kubectl ${CMD} -f -
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: wordpress
  namespace: ${NAMESPACE}
spec:
  tls:
    - hosts:
      - vocon-it.com
      secretName: vocon-it-com-tls
  rules:
    - host: vocon-it.com
      http:
        paths:
          - backend:
             serviceName: wordpress
             servicePort: 80
EOF
