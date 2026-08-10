# AGENTS.md — SZEFCIO Public Media capability repository

```text
REPOSITORY=dkknapikdamian-collab/szefcio-public-media
REPOSITORY_CLASS=CAPABILITY_REPOSITORY
PROJECT_ID=null
OBSIDIAN_PROJECT_ID=null
CANONICAL_BRANCH=main
```

## READ_FIRST

1. `_project/PROJECT_MANIFEST.json`.
2. Classify the task.
3. `_project/AGENT_CAPABILITIES.json`.
4. `_project/WORKFLOW_STATE.json` when workflow context is required.
5. Exactly `current_workflow.contract_path`.
6. README/media inventory only as required by the task.

This repository is a shared public-media capability, not a standalone canonical Obsidian project. Do not infer a project owner from filenames, consumers, or the SZEFCIO prefix.

Code/security/release/refactor/API/database/technical implementation task classes require AI Code Guardian; required capability unavailable means `BLOCKED_REQUIRED_CAPABILITY_UNAVAILABLE`. Read-only media inventory, business analysis and pure wiki work do not require Guardian by default.

Do not store current SHA, PR, deployment or stage snapshots here. Do not create a project_id or Obsidian project without owner-backed identity evidence.
