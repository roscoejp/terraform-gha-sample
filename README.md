# terraform-gha-sample

- GHA workflow for triggering Terraform plans/applies based on PRs
- Open a PR to trigger a plan
  - Plan output saved to GHA artifact
  - PR comment updated
- Approve and close PR to trigger an apply
  - If build fails, fix workflow and open a new PR
  - New comment added to PR with apply information
