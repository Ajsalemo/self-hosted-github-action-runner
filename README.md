# self-hosted-github-action-runner

A self-hosted runner following this [tutorial](https://learn.microsoft.com/en-us/azure/container-apps/tutorial-ci-cd-runners-jobs?tabs=bash&pivots=container-apps-jobs-self-hosted-ci-cd-github-actions) with some slight changes to make testing scenarios easier.

To run:
1. Fill out the variables in `variables.sh` and run `source variables.sh`
2. Run the command for `az containerapp job create` in `deploy-self-hosted-runner-as-jobs.sh`