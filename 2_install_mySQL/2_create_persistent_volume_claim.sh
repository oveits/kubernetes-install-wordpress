
cat > persistentVolumeClaimMySql.yaml << EOF
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mysql-pv-claim
  namespace: mysql-staging
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: my-local-storage-class
  resources:
    requests:
      storage: 20Gi
EOF

kubectl create -f persistentVolumeClaimMySql.yaml
