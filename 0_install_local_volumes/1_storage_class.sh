

cat > myLocalStorageClass.yaml << EOF
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: my-local-storage-class
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF

if [ "$1" == "-d" ]; then
   kubectl delete -f myLocalStorageClass.yaml
else
   kubectl create -f myLocalStorageClass.yaml
fi
