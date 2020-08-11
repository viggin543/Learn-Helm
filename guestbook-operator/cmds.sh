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
k apply -f guestbook-operator/deploy/crds/helm.operator-sdk_v1alpha1_guestbook_cr.yaml -n gitops

# . Because the release history is not retained,
# the Helm-based operator does not allow you to perform an explicit rollback
# this can be achieved by applying changes to the custom resource values

k delete -f guestbook-operator/deploy/crds/helm.operator-sdk_v1alpha1_guestbook_cr.yaml -n gitops
k delete pvc -n gitops -l app=redis
kubectl delete -f deploy -n gitops # remove the operator


