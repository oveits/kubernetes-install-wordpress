
source $CONFIG_FILE
[ "$1" == "-d" ] && CMD=delete || CMD=apply

if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0"
  exit 1
fi

cat << EOF | kubectl $CMD -f -
---
apiVersion: v1
kind: Service
metadata:
  name: wordpress-mysql
  namespace: ${NAMESPACE}
  labels:
    app: wordpress
spec:
  ports:
    - port: 3306
  selector:
    app: wordpress
    tier: mysql
  clusterIP: None
EOF

