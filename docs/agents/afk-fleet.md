# afk-fleet config (per-repo)

Read by the afk-fleet skill on startup. This repo is a **zh+en documentation/tutorial** repo
with no CI and no build/test — so the completion gate leans on the issue's acceptance criteria
plus an **independent adversarial verification** pass (a machine gate can't catch wrong prose).

```yaml
# Only what differs from the defaults (`afk config --defaults` prints those; the
# annotated list is the skill's references/config-template.md).

# --- completion gate ---
gate:
  adversarial_verify_prompt: "Re-read the PR diff against the linked issue's acceptance criteria. Refute (block the merge) if: a zh change lacks its en counterpart (or vice-versa) when the issue asks for both; it edits the wrong chapter / file / ADR, or misnumbers something; it introduces a broken internal link or a 'Next' pointer that doesn't resolve; it drops or contradicts a bullet the issue explicitly requested. Post any refutation as a PR review comment and treat it as a retry reason."
```

## Notes

- **Progressive gate.** `gate.ci` is left at its default, `required`: the repo has no
  `.github/workflows` today, so a PR has no checks and the adversarial verify is its only gate. Once
  CI is added, merges wait on green checks with nothing to change here.
- **Adversarial verify is on** (`gate.adversarial_verify_prompt` is set) because this is a correctness-sensitive content repo (a published zh+en
  tutorial); a machine gate can't tell good prose from wrong prose, so an independent reviewer does.
- **Deploy is out of scope.** The fleet's mandate ends at a green merge to `main`.
- **Reserved labels, refs & the status comment.** The fleet manages the `afk-attempt/<n>` labels, the
  hidden `refs/afk/*` namespace (`afk-claim/<n>`, `afk-heartbeat/<id>`), and the single status-board
  comment tagged `<!--afk:status-->`. Don't hand-edit them or reuse those prefixes / that marker.
