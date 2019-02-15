
source $CONFIG_FILE
[ "$1" == "-d" ] && CMD=delete || CMD=apply

###
# create key file and environment variables
###

source $HOME/.cloudflare/credentials.sh || exit "credentials file $HOME/.cloudflare/credentials.sh not found"
# the file $HOME/.cloudflare/credentials.sh is assumed to have the format
# EMAIL=your_cloudflare_email_address
# ZONE=your_cloudflare_zone
# GLOBAL_API_KEY=your_cloudflare_global_api_key

touch cloudflare-api-key.txt
chmod 600 cloudflare-api-key.txt
echo -n $GLOBAL_API_KEY > cloudflare-api-key.txt

kubectl delete secret cloudflare-api-key --namespace=$NAMESPACE 2>/dev/null
kubectl create secret generic cloudflare-api-key --from-file=cloudflare-api-key.txt --namespace=$NAMESPACE

rm cloudflare-api-key.txt

###
# create issuer
###

[ "$1" == "-d" ] && CMD=delete || CMD=apply

cat << EOF | kubectl $CMD -f -
---
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: letsencrypt-staging-dns
  namespace: ${NAMESPACE}
spec:
  acme:
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    email: ${EMAIL}
    privateKeySecretRef:
      name: letsencrypt-staging-dns
    dns01:
      providers:
        - name: cloudflare
          cloudflare:
            email: ${EMAIL}
            zone: ${ZONE}
            apiKeySecretRef: 
              name: cloudflare-api-key
              key: cloudflare-api-key.txt
EOF

