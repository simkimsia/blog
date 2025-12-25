# Notes for Git Setup Guide Revision

## Feedback from Windows User

1. **Issue:** The user needs to download "antigravity" (likely referring to Git or the relevant software) and was stumped not knowing whether they are on an **x64** or **ARM** chip.
   - **Possible Solution:** Add instructions on how to check the system architecture on Windows (e.g., via *Settings > System > About*).

2. **Issue:** Users may not be familiar with the backtick key (`` ` ``), which is essential for Markdown and code blocks.
   - **Possible Solution:** Add a small tip or image showing where the backtick key is located (usually above Tab/below Esc) and distinctions from a single quote text.

3. **Issue:** When first installing "antigravity" on Windows, the onboarding process may take some time to complete.
   - **Advice:** Ignore the onboarding and just go straight to terminal > New Terminal

4. ~~**General Improvement:** All external links in the guide should open in a new tab (`target="_blank"`).~~ ✅ **IMPLEMENTED**
   - **Action:** Update markdown links (or enable a relevant MkDocs plugin configuration) so that external resources don't navigate the user away from the guide.

5. **Issue:** Copy-pasting commands (like `git --version`) into the terminal sometimes triggers a `>>` continuation prompt (meaning the shell thinks the command is incomplete).
   - **Possible Solution:** Warn users about this behavior and instruct them to press `Ctrl+C` to cancel if they see `>>`, or ensure they aren't copying extra lines/quotes.

6. **Issue:** GitHub Desktop sign-in options can be confusing (GitHub.com vs GitHub Enterprise).
   - **Advice:** Explicitly state that users should choose to sign into **GitHub.com** when prompted.

7. **Issue:** During GitHub Desktop setup, users might miss the browser authorization step.
   - **Advice:** Remind users to look for the "Authorize application" prompt in their web browser and click to approve access for GitHub Desktop.

8. **Issue:** "eval term not recognized" error in Windows VS Code terminal.
   - **Cause:** Users are running `eval "$(ssh-agent -s)"` (Git Bash syntax) in PowerShell, which does not support the `eval` command.
   - **Simplified Solution:** Since we are NOT recommending a passphrase for SSH keys, we can entirely **skip** the `eval ssh-agent` and `ssh-add` steps on Windows.
   - **Action:** Update the guide to instruct users to press Enter (empty passphrase) during `ssh-keygen`. Then SSH will work automatically without needing the agent commands.

9. **Issue:** `clip < ~/.ssh/id_ed25519.pub` fails in PowerShell.
   - **Cause:** The `<` input redirection operator works differently or is less reliable in PowerShell for this specific `clip` command usage compared to cmd.exe or Bash.
   - **Solution:** Use the PowerShell native command to copy content:
     `Get-Content ~\.ssh\id_ed25519.pub | Set-Clipboard`
   - **Alternative:** Instruct user to manually open the file (`code ~/.ssh/id_ed25519.pub`) and copy the text.

10. **UX Feedback:** User prefers **collapsible sections** at each step so they can toggle to mark where they stopped or which step to focus on.
    - **Action:** Consider using `???+` (collapsed by default) or `???` admonitions for each major step, allowing users to expand only the step they're working on and visually track progress.

11. **Enhancement:** Add **OS tab sync** so that selecting "Windows" or "macOS" in one step automatically switches all other OS-specific tabs on the page.
    - **Implementation:** Enable MkDocs Material feature `content.tabs.link` in `mkdocs.yml`. This is built-in and also persists the user's choice via localStorage.

12. **Enhancement:** Add **"Expand All" / "Collapse All"** buttons at the top of the guide.
    - **Implementation:** Add custom JavaScript (~20 lines) to toggle all collapsible `<details>` elements on the page. This helps users quickly expand everything for reference or collapse to focus on one step at a time.

13. ~~**Enhancement:** Add an **"Opinionated Defaults" / "Our Recommendations"** section at the top of the guide.~~ ✅ **IMPLEMENTED**
    - **Purpose:** Reduce decision fatigue for beginners by clearly stating what choices we've made for them.
    - **Recommended defaults for Windows:**
      - Terminal: Use the one in VS Code (or forks like Cursor, Windsurf)
      - Shell: **Git Bash** (not PowerShell) — to learn transferable Linux commands
      - Git commands: Don't memorize — use GUI client like GitHub Desktop
      - Authentication: SSH keys with no passphrase
      - Commit email: Use GitHub's noreply email for privacy
      - Version control host: GitHub.com

14. **Critical:** Add a step to **switch VS Code's default terminal to Git Bash** on Windows before any commands.
    - **Rationale:** We want users to learn Linux/Unix commands (`ls`, `cp`, `rm`, `ssh-add`, `clip`, etc.) that are transferable to macOS, Linux servers, WSL, and remote environments.
    - **This resolves issues #8 and #9** — `eval` and `clip <` will work correctly in Git Bash.