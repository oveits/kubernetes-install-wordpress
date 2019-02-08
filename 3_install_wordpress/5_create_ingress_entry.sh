

if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0"
  exit 1
fi

cat <<EOF | kubectl apply -f -
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: wordpress
  namespace: ${NAMESPACE}
spec:
  rules:
    - host: vocon-it.com
      http:
        paths:
          - backend:
             serviceName: wordpress
             servicePort: 80
EOF
