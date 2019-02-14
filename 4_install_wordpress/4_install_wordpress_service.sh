
source $CONFIG_FILE
[ "$1" == "-d" ] && CMD=delete || CMD=apply

if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0"
  exit 1
fi

#kubectl -n ${NAMESPACE} expose deployment wordpress --port=80
#exit 0

cat << EOF | kubectl $CMD -f -
---
apiVersion: v1
kind: Service
metadata:
  name: wordpress
  namespace: ${NAMESPACE}
  labels:
    app: wordpress
spec:
  ports:
    - port: 80
  selector:
    app: wordpress
    tier: frontend
  type: ClusterIP
EOF

