# afk-fleet config (per-repo)

Read by the afk-fleet skill on startup. This repo is a **zh+en documentation/tutorial** repo
with no CI and no build/test — so the completion gate leans on the issue's acceptance criteria
plus an **independent adversarial verification** pass (a machine gate can't catch wrong prose).

```yaml
# --- dispatch contract ---
ready_label: ready-for-agent          # a child issue is dispatchable when it carries this
                                      #   (a human reserves an issue by REMOVING this label)
epic_labels: [epic, prd]              # never dispatched (none exist in this repo today; harmless guard)
claim: ref                            # atomic lock ref refs/afk/claim/<n> marks an issue as taken (ADR-0003)
dependencies: native                  # GitHub native blocked_by (open blockers gate dispatch)

# --- workers ---
base_branch: main
branch_pattern: "issue-{number}-{slug}"   # worktree-NAME hint passed to `orca worktree create --name`;
                                      #   orca sets the real branch (prefixed <user>/…) — ADR-0005
worker: orca                          # orca creates the worktree + branch and spawns Claude Code in one step
concurrency: 3                        # max workers running at once (matches the 3 ready issues today)
worktree_cleanup: true                # after merge/escalate, remove via `orca worktree rm issue:<n>`

# --- completion gate ---
gate:
  ci: none                            # no GitHub workflows in this repo — nothing to wait on
  local_command: ""                   # no build/test to run pre-PR
  adversarial_verify: true            # content repo: an independent agent re-derives the result and
                                      #   refutes drift BEFORE merge (refute-first)
  adversarial_verify_prompt: |
    Re-read the PR diff against the linked issue's acceptance criteria. Refute (block the merge) if:
    - a zh change lacks its en counterpart (or vice-versa) when the issue asks for both,
    - it edits the wrong chapter / file / ADR, or misnumbers something,
    - it introduces a broken internal link or a "Next" pointer that doesn't resolve,
    - it drops or contradicts a bullet the issue explicitly requested.
    Post any refutation as a PR review comment and treat it as a retry reason.

# --- merge ---
merge:
  strategy: squash                    # squash | merge | rebase
  target: main                        # fleet stops here; deploy is a separate human-gated step
  rebase_before_merge: true           # serialized: rebase onto latest main, re-gate, then merge
  delete_branch: true

# --- failure handling ---
retry: 2                              # per-issue retries; count tracked via an afk-attempt/<n> label
escalate_label: ready-for-human       # applied (ready_label removed, claim ref deleted) on give-up
escalate_comment: true                # comment the stuck-point + PR/log links

# --- progress (human-facing) ---
progress_comment: true                # upsert ONE "status board" comment per issue (checklist rendered
                                      #   from fleet state; human-read only, never a tick input — ADR-0006)

# --- loop (launcher pacing) ---
busy_interval_seconds: 90             # re-tick soon (~1.5 min) when the last tick had work / in-flight PRs
idle_interval_seconds: 1500           # slow re-tick (~25 min) when idle
idle_ticks_before_sleep: 3            # this many empty ticks (frontier empty + no in-flight) → idle cadence
claim_lease_ttl_seconds: 4500         # a claim is live while its owner's heartbeat is this fresh (~75 min)
```

## Notes

- **Progressive gate.** `gate.ci: none` reflects today's repo (no `.github/workflows`). If CI is added
  later, flip this to `required` so merges wait on green checks.
- **Adversarial verify is on** because this is a correctness-sensitive content repo (a published zh+en
  tutorial); a machine gate can't tell good prose from wrong prose, so an independent reviewer does.
- **Deploy is out of scope.** The fleet's mandate ends at a green merge to `main`.
- **Reserved labels, refs & the status comment.** The fleet manages the `afk-attempt/<n>` labels, the
  hidden `refs/afk/*` namespace (`afk-claim/<n>`, `afk-heartbeat/<id>`), and the single status-board
  comment tagged `<!--afk:status-->`. Don't hand-edit them or reuse those prefixes / that marker.
