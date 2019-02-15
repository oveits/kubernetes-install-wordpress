
source $CONFIG_FILE
[ "$1" == "-d" ] && CMD=delete || CMD=apply

cat << EOF | kubectl $CMD -f -
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: wordpress
  namespace: ${NAMESPACE}
spec:
  rules:
    - host: ${BOX}.vocon-it.com
      http:
        paths:
          - backend:
             serviceName: wordpress
             servicePort: 80
EOF
