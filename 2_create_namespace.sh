
source $CONFIG_FILE

# create namespace:
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Namespace
metadata:
  name: $NAMESPACE
EOF

