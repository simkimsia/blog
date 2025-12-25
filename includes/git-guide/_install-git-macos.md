### macOS Installation

#### Check if Git is Already Installed

Open your terminal and run:

```bash
git --version
```

- **See a version number?** (e.g., `git version 2.39.0`) → You're done! Skip to [Step 4](#step-4-gui-client-recommended).
- **Get an error or prompt to install?** → Continue below.

---

#### Install Git

=== "Xcode Command Line Tools (Easiest)"

    The simplest way — no extra software needed:

    ```bash
    xcode-select --install
    ```

    A popup will appear — click **Install** and wait for completion (may take a few minutes).

=== "Homebrew (Popular)"

    [Homebrew](https://brew.sh/){: target="_blank" } is a package manager for macOS — like an app store for command-line tools.

    **First, check if you have Homebrew:**

    ```bash
    brew --version
    ```

    ??? question "Don't have Homebrew? Install it first"

        Run this in your terminal:

        ```bash
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ```

        Follow the prompts. After installation, you may need to run the commands shown to add Homebrew to your PATH.

    **Then install Git:**

    ```bash
    brew install git
    ```

=== "Download Installer"

    1. Download from [git-scm.com/download/mac](https://git-scm.com/download/mac){: target="_blank" }
    2. Open the `.dmg` file and run the installer
    3. Follow the installation prompts

---

#### Verify Installation

```bash
git --version
```

You should see something like `git version 2.39.0`.
