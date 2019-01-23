
if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0"
  exit 1
fi

cat > persistentVolumeClaimMySql.yaml << EOF
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

if [ "$1" == "-d" ]; then
   kubectl delete -f persistentVolumeClaimMySql.yaml
else
   kubectl create -f persistentVolumeClaimMySql.yaml
fi
