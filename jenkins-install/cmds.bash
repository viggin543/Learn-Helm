 helm install jenkins codecentric/jenkins \
  -n gitops --version 1.5.1 \
  --values values.yaml \
  --set githubUsername=$GITHUB_USER \
  --set githubPassword=$GITHUB_PASS \
  --set githubForkUrl=https://github.com/$GITHUB_USER/-Learn-Helm.git \
  --set githubPagesRepoUrl=https://github.com/$GITHUB_USER/Learn-Helm.git