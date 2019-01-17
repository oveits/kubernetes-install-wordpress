

# create template
cat > persistentVolume.yaml.tmpl << 'EOF'
apiVersion: v1
kind: PersistentVolume
metadata:
  name: vol${i}
spec:
  capacity:
    storage: 500Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: my-local-storage-class
  local:
    path: /mnt/disk/vol${i}
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - ${NODE}
EOF

export NODE=$(hostname)
for i in $(seq 1 100);
do
  export i=$i

  # create directory on the node, where the POD will be located (current node in our case):
  DIRNAME="vol${i}"
  sudo test -d /mnt/disk/$DIRNAME || sudo mkdir -p /mnt/disk/$DIRNAME 
  sudo chcon -Rt svirt_sandbox_file_t /mnt/disk/$DIRNAME
  sudo chmod 777 /mnt/disk/$DIRNAME

  # create persistentVolume
  envsubst < persistentVolume.yaml.tmpl > persistentVolume.yaml
  kubectl apply -f persistentVolume.yaml
done    
