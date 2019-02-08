
helm version

# install helm, if it is not already installed:
if [ "$?" != "0" ]; then
  curl -s -o helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz \
  && mkdir helm-download
  && cd helm-download
  && sudo tar -zxvf helm.tar.gz \
  && sudo cp -p -f linux-amd64/helm /usr/local/bin/ \
  && helm init \
  && cd .. \
  && sudo rm -Rf helm-download  # cleaning
fi


