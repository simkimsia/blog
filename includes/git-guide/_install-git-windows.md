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

=== "Git for Windows (Recommended)"

    1. Download from [git-scm.com/download/win](https://git-scm.com/download/win){: target="_blank" }
    2. Run the installer
    3. **Recommended settings during install:**
        - ✅ **Git Bash Here** — adds right-click context menu
        - ✅ **Use Git from Windows Terminal** — so you can use `git` in PowerShell
        - ✅ **Use bundled OpenSSH** — for SSH key support

    !!! tip "Not sure which options to pick?"
        The defaults are fine for most users. Just click "Next" through the installer.

=== "winget (Built-in)"

    Windows 10/11 has a built-in package manager called `winget`.

    **Check if you have winget:**

    ```powershell
    winget --version
    ```

    ??? question "Don't have winget?"

        winget comes pre-installed on Windows 11 and recent Windows 10 updates. If you don't have it:

        1. Open **Microsoft Store**
        2. Search for "App Installer"
        3. Install or update it

    **Install Git:**

    ```powershell
    winget install --id Git.Git -e --source winget
    ```

=== "Chocolatey"

    [Chocolatey](https://chocolatey.org/){: target="_blank" } is a package manager for Windows.

    **First, check if you have Chocolatey:**

    ```powershell
    choco --version
    ```

    ??? question "Don't have Chocolatey? Install it first"

        Open **PowerShell as Administrator** (right-click → "Run as administrator") and run:

        ```powershell
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        ```

    **Then install Git:**

    ```powershell
    choco install git
    ```

---

#### Verify Installation

Open a **new** terminal window (important!) and run:

```powershell
git --version
```

You should see something like `git version 2.42.0.windows.1`.

!!! warning "Command not found after install?"
    Close and reopen your terminal. The PATH is only updated for new terminal sessions.
