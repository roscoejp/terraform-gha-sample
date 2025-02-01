# terraform-gha-sample

- GHA workflow for triggering Terraform plans/applies based on PRs
- (Re)open a PR to trigger a plan
  - Plan output saved to GHA artifact OR store hash of plan output text as HTTP comment in PR comment
    - OR becasue storing the tfplan means that _any_ config drift is messy. Forcing a linear history would help this (would force rebasing of stale PR branches) but I think there may be a way to compare the desired outputs between plans via hashes that may allow for changes to elements that aren't necessary for a given plan. Want to noodle on this.
    - If you store the artifact, put the artifact and actions IDs into comments in the PR for easy lookup later.
  - PR comment update
- Merging PR to main triggers an apply
  - Grab plan output hash from comment in PR
  - TF plan, check if hashed plan output matches hash of stored plan output
  - New comment added to PR with apply information
  - If apply fail, re-open PR (which should generate new plan)
    - if using a PAT this may require a manual step to re-trigger the plan since you can't chain actions using default tokens or the PR APIs

dflook has some nice ideas around [storing plan information in comment headers](https://github.com/dflook/terraform-github-actions/blob/main/image/src/github_pr_comment/comment.py#L22-L44) using [json html comments](https://github.com/dflook/terraform-github-actions/blob/main/image/src/github_pr_comment/comment.py#L156). I hand't thought of stuffing json in these even thought I've used the invidisble html comments for metadata before... very smort imo.

There's also an idea of using github issue templates to update tfvars files present here. Process there is relatively simple:
  - Issue template used to file a new issue
    - template should have tfvar keys as input names and the values as strings.
  - Actions converts the issue template to a tfvars.json file using https://github.com/marketplace/actions/github-issue-parser because we don't need to reinvent the wheel.
  - PR gets created with the new tfvars.json file moved somewhere TF can access it
  - Kicks off the normal PR process above (this is tedious without a PAT, may be easiest to include a task to manually kickoff the plan workflow using the generated PR information from the issue workflow to keep everything tidy)