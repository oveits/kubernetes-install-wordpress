
if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; $0"
  exit 1
fi

kubectl -n ${NAMESPACE} expose deployment wordpress --port=80

exit 0

cat <<EOF > wordpressService.yaml
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
  clusterIP: None
EOF

kubectl create -f mysqlService.yaml
