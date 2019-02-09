
if [ "$NAMESPACE" == "" ]; then
  echo "usage: export NAMESPACE=staging; bash $0"
  exit 1
fi

source $HOME/.cloudflare/credentials.sh || exit "credentials file $HOME/.cloudflare/credentials.sh not found"
# the file $HOME/.cloudflare/credentials.sh is assumed to have the format
# EMAIL=your_cloudflare_email_address
# GLOBAL_API_KEY=your_cloudflare_global_api_key

touch cloudflare-api-key.txt
chmod 400 cloudflare-api-key.txt
echo $GLOBAL_API_KEY > cloudflare-api-key.txt

[ "$1" == "-d" ] && CMD=delete || CMD=apply

cat <<EOF | kubectl $CMD -f -
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
        - name: my-cloudflare-provider
          cloudflare:
            email: ${EMAIL}
            apiKeySecretRef: 
              name: cloudflare-api-key
              key: cloudflare-api-key.txt
EOF

rm cloudflare-api-key.txt
