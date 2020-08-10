helm upgrade jenkins codecentric/jenkins \
  -n gitops --version 1.5.1 \
  --reuse-values --set githubPagesSiteUrl=$GITHUB_PAGES_SITE_URL