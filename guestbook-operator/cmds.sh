 operator-sdk new guestbook-operator --type=helm \
  --helm-chart=guestbook \
  --helm-chart-repo=https://viggin543.github.io/Learn-Helm/stable

 operator-sdk build  domrevigor/guestbook-operator

docker push domrevigor/guestbook-operator

kubectl apply -f deploy/crds/helm.operator-sdk_guestbooks_crd.yaml #create guestbook crd

sed  -i .back 's%REPLACE_IMAGE%docker.io/domrevigor/guestbook-operator%'  deploy/operator.yaml

kubectl apply -f deploy -n gitops

kubectl apply -f deploy/crds/helm.operator-sdk_v1alpha1_guestbook_cr.yaml # this will cause the operator to install out chart

# modify redis slaves count in guestbook cr and apply to cluster, operator will upgrade the chart
