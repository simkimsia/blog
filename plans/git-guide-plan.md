# Git Installation & Usage Guide for Beginners

A modular, checklist-style guide using pymdownx.snippets to handle different user scenarios (OS, existing accounts, SSH keys, etc.).

## Proposed Changes

### Snippets Directory Structure

#### [NEW] includes/git-guide/

Create a dedicated folder for Git guide snippets:

```
includes/git-guide/
├── _install-git-macos.md         # macOS: CLI (Homebrew/Xcode) + GUI options
├── _install-git-windows.md       # Windows: CLI + GUI options
├── _gui-github-desktop.md        # GitHub Desktop setup
├── _gui-git-tower.md             # Git Tower setup
├── _create-github-account.md     # Steps to create GitHub account
├── _check-ssh-key.md             # Check for existing SSH keys
├── _create-ssh-key-macos.md      # Generate SSH key on macOS
├── _create-ssh-key-windows.md    # Generate SSH key on Windows
├── _add-ssh-to-github.md         # Add SSH key to GitHub
├── _configure-git-identity.md    # Set name and email
├── _first-clone.md               # Clone your first repo
├── _first-commit.md              # Make your first commit
└── _common-commands.md           # Quick reference
```

---

### Main Guide Page

#### [NEW] [git-for-beginners.md](file:///Users/kimsia/Projects/blog/docs/git-for-beginners.md)

The main page serves as a checklist/flowchart that conditionally includes snippets. Example structure:

```markdown
# Git Installation & Setup Guide

## Step 1: Check Your Operating System

=== ":fontawesome-brands-apple: macOS"
    --8<-- "includes/git-guide/_install-git-macos.md"

=== ":fontawesome-brands-windows: Windows"
    --8<-- "includes/git-guide/_install-git-windows.md"

## Step 2: GitHub Account

- [ ] **Already have a GitHub account?** Skip to Step 3
- [ ] **Need an account?** Follow these steps:

--8<-- "includes/git-guide/_create-github-account.md"

## Step 3: SSH Key Setup

??? question "Do you already have an SSH key?"
    --8<-- "includes/git-guide/_check-ssh-key.md"

??? question "Need to create a new SSH key?"
    --8<-- "includes/git-guide/_create-ssh-key.md"
    --8<-- "includes/git-guide/_add-ssh-to-github.md"
```

---

### MkDocs Configuration

#### [MODIFY] [mkdocs.yml](file:///Users/kimsia/Projects/blog/mkdocs.yml)

Update the `pymdownx.snippets` configuration to include the new snippets base path and add the guide to navigation.

**Changes:**
1. Add `includes/git-guide` to snippets `base_path` (or keep relative paths)
2. Add new navigation entry for the Git guide

---

## Key Design Decisions

### Why This Structure?

1. **OS-specific content**: Using Material's content tabs (`===`) to show only the relevant OS instructions
2. **Conditional sections**: Using `???` (collapsible admonitions) for "if you have X, do Y" scenarios
3. **Checklist format**: Native MkDocs tasklist (`- [ ]`) for tracking progress
4. **Modular snippets**: Each scenario is a separate file, making it easy to:
   - Update one OS without affecting others
   - Reuse snippets in other guides
   - Keep the main guide clean and readable

### Scenario Handling Examples

| Scenario | Solution |
|----------|----------|
| Different OS | Content tabs (macOS/Windows) |
| Has/doesn't have GitHub account | Collapsible section with checklist |
| Has/doesn't have SSH key | Collapsible question with check command |
| Wants new SSH key despite having one | Separate snippet for "create new anyway" |
| Different skill levels | Progressive disclosure with admonitions |

## Verification Plan

### Manual Verification

1. Run `mkdocs serve --watch includes --watch overrides` locally
2. Navigate to the new Git guide page
3. Verify:
   - Content tabs switch correctly between OS instructions
   - Snippets are included properly (no raw snippet syntax visible)
   - Collapsible sections expand/collapse
   - All links work

---

## User Review Required

> [!IMPORTANT]
> Please review the following questions before I proceed:

1. **Location**: Should this be a top-level nav item, or nested under an existing section like "Writing"?

2. **Snippet scenarios to cover**: I've proposed common scenarios. Are there others you want to include?
   - Different Git hosts (GitLab, Bitbucket)?
   - HTTPS vs SSH authentication?
   - GUI vs CLI preference?

3. **Style preference**: Do you prefer:
   - Content tabs for OS selection (side-by-side visual)
   - Collapsible admonitions (vertical flow)
   - Both mixed as shown above

4. **Naming**: Is `git-for-beginners.md` a good filename, or would you prefer something else?
