### Windows Installation

#### Check if Git is Already Installed

Open **your terminal in VSCode** and run:

```bash
git --version
```

- **See a version number?** (e.g., `git version 2.42.0.windows.1`) → You're done! Skip to [Step 4](#step-4-gui-client-recommended).
- **Get an error?** (e.g., `'git' is not recognized`) → Continue below.

---

#### Install Git

1. Download from [git-scm.com/download/win](https://git-scm.com/download/win){: target="_blank" }
2. Run the installer
3. **Recommended settings during install:**
    - ✅ **Git Bash Here** — adds right-click context menu
    - ✅ **Use Git from Windows Terminal** — so you can use `git` in PowerShell
    - ✅ **Use bundled OpenSSH** — for SSH key support

!!! tip "Not sure which options to pick?"
    The defaults are fine for most users. Just click "Next" through the installer.

---

#### Verify Installation

Open a **new** terminal window (important!) and run:

```powershell
git --version
```

You should see something like `git version 2.42.0.windows.1`.

!!! warning "Command not found after install?"
    Close and reopen your terminal. The PATH is only updated for new terminal sessions.
