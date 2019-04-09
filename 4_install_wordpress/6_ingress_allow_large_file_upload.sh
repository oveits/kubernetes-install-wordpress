

[ "$1" == "-d" ] && CMD=delete || CMD=apply

# set max body size and timeout to 2GB and 1200 sec, respectively:
cat << EOF | kubectl $CMD -f -
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
  namespace: nginx-ingress
data:
  client-max-body-size: 2048m
  proxy-connect-timeout: 30s
  proxy-read-timeout: 1200s
  namespace: nginx-ingress
EOF

# apply new config by restarting the nginx ingress PODs, if present:
PODS=$(kubectl get pod -n nginx-ingress | grep '^nginx-ingress' | awk '{print $1}')
echo $PODS | xargs kubectl delete pod 

