

cat > myLocalStorageClass.yaml << EOF
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: my-local-storage-class
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF

kubectl create -f myLocalStorageClass.yaml
