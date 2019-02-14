
source $CONFIG_FILE

if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0"
  exit 1
fi

[ "$1" == "-d" ] && CMD=delete || CMD=apply

cat << EOF | kubectl $CMD -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mysql-pv-claim
  namespace: ${NAMESPACE}
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: my-local-storage-class
  resources:
    requests:
      storage: 20Gi
EOF

