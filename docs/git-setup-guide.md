---
categories:
- For Beginners in Tech
description: Set up Git and GitHub with this beginner-friendly guide, featuring installation
  steps, SSH setup, and first repository creation.
tags:
- Git
- GitHub
- Beginners
- Version Control
- SSH Setup
title: Git Installation & Setup Guide
---

# Git Installation & Setup Guide

A step-by-step checklist to get you set up with Git and GitHub. Check off each step as you complete it.

!!! abstract "Target Audience"
    This guide is designed for **beginners** who want to write code using either **Windows 11** or **macOS**.

!!! tip "Our Recommended Setup"

    This guide is **opinionated** — we've made the choices for beginners so you can focus on learning.

    | Choice | Our Recommendation |
    |--------|-------------------|
    | **Terminal** | Use the one built into VS Code (or forks like Cursor, Windsurf) |
    | **Shell** | Git Bash (Windows), Your default is good enough (macOS/Linux) |
    | **Git commands** | Don't memorize them — use GUI clients like **GitHub Desktop** for daily work |
    | **Authentication** | SSH keys (no passphrase for simplicity) |
    | **Commit email** | Use your GitHub "noreply" email to keep your real email private |
    | **Git hosting** | GitHub.com |

??? info "Why these choices?"
    - **Terminal - Use the one inside VSCode, or VSCode-like IDEs**: Most beginners learn git because they are also learning code. Using the terminal built into VSCode or VSCode-like IDEs is a great way to get started.
    - **Windows - Git Bash over PowerShell**: The commands you learn (`ls`, `rm`, `ssh-add`, `cat`) work on macOS, Linux servers, and WSL — PowerShell cmdlets don't transfer.
    - **GUI clients**: Muscle memory for CLI commands comes later. GUIs reduce errors while you're learning concepts.
    - **SSH with no passphrase**: More secure than HTTPS. No passphrase simplifies setup for beginners. You can add a passphrase later for extra security.
    - **Noreply email**: Your email is visible in every commit's metadata. GitHub provides a private `@users.noreply.github.com` address to protect your inbox.

---

## :fontawesome-solid-terminal: Step 1: Open Your Terminal

--8<-- "includes/git-guide/_open-terminal.md"

---

## :fontawesome-solid-circle-check: Step 2: Do You Have a GitHub Account?

- [ ] **Already have a GitHub account?** → Skip to [Step 3](#step-3-install-git)
- [ ] **Need an account?** → Follow these steps:

--8<-- "includes/git-guide/_create-github-account.md"

---

## :fontawesome-solid-download: Step 3: Install Git

Choose your operating system:

=== ":fontawesome-brands-apple: macOS"

    --8<-- "includes/git-guide/_install-git-macos.md"

=== ":fontawesome-brands-windows: Windows"

    --8<-- "includes/git-guide/_install-git-windows.md"

---

## :fontawesome-solid-desktop: Step 4: GUI Client (Recommended)

We recommend using a GUI (graphical) client — it's easier than the command line for beginners.

??? note "GitHub Desktop — Free, beginner-friendly :star:"

    --8<-- "includes/git-guide/_gui-github-desktop.md"

??? note "Git Tower — Paid (Free for Students)"

    --8<-- "includes/git-guide/_gui-git-tower.md"

!!! info "Prefer the command line?"
    That's fine too! The rest of this guide uses CLI commands, which work with or without a GUI client.

---

## :fontawesome-solid-key: Step 5: SSH Key Setup

SSH keys let you securely connect to GitHub without entering your password each time.

### 5a. Check for Existing Keys

=== ":fontawesome-brands-apple: macOS"

    --8<-- "includes/git-guide/_check-ssh-key-macos.md"

=== ":fontawesome-brands-windows: Windows"

    --8<-- "includes/git-guide/_check-ssh-key-windows.md"

### 5b. Create a New SSH Key

Choose your operating system:

=== ":fontawesome-brands-apple: macOS"

    --8<-- "includes/git-guide/_create-ssh-key-macos.md"

=== ":fontawesome-brands-windows: Windows"

    --8<-- "includes/git-guide/_create-ssh-key-windows.md"

### 5c. Add SSH Key to GitHub

--8<-- "includes/git-guide/_add-ssh-to-github.md"

---

## :fontawesome-solid-user: Step 6: Configure Git Identity

--8<-- "includes/git-guide/_configure-git-identity.md"

---

## :fontawesome-solid-rocket: Step 7: Your First Repository

=== ":fontawesome-brands-apple: macOS"

    === "CLI"

        #### Clone a Repository

        ```bash
        git clone git@github.com:username/repository.git
        ```

        !!! tip "Finding the SSH URL"
            On GitHub, click the green **Code** button → select **SSH** → copy the URL.

        #### Make Your First Commit

        ```bash
        cd repository
        # Make changes to files...
        git add .
        git commit -m "Your commit message"
        git push
        ```

    === "GitHub Desktop"

        #### Clone a Repository

        1. Open GitHub Desktop
        2. **File → Clone Repository** (or `Cmd+Shift+O`)
        3. Select the **GitHub.com** tab
        4. Choose a repository from your list (or paste a URL)
        5. Click **Clone**

        #### Make Your First Commit

        1. Make changes to files in your editor
        2. In GitHub Desktop, you'll see changed files in the left panel
        3. Add a **Summary** (commit message) at the bottom
        4. Click **Commit to main**
        5. Click **Push origin** to upload

    === "Git Tower"

        #### Clone a Repository

        1. Open Git Tower
        2. **File → Clone** (or `Cmd+Shift+C`)
        3. Paste the repository URL
        4. Choose where to save it
        5. Click **Clone**

        #### Make Your First Commit

        1. Make changes to files in your editor
        2. In Tower, go to the **Working Copy** view
        3. Stage files by clicking the **+** button
        4. Enter a commit message and click **Commit**
        5. Click **Push** to upload

=== ":fontawesome-brands-windows: Windows"

    === "CLI"

        #### Clone a Repository

        ```powershell
        git clone git@github.com:username/repository.git
        ```

        !!! tip "Finding the SSH URL"
            On GitHub, click the green **Code** button → select **SSH** → copy the URL.

        #### Make Your First Commit

        ```powershell
        cd repository
        # Make changes to files...
        git add .
        git commit -m "Your commit message"
        git push
        ```

    === "GitHub Desktop"

        #### Clone a Repository

        1. Open GitHub Desktop
        2. **File → Clone Repository** (or `Ctrl+Shift+O`)
        3. Select the **GitHub.com** tab
        4. Choose a repository from your list (or paste a URL)
        5. Click **Clone**

        #### Make Your First Commit

        1. Make changes to files in your editor
        2. In GitHub Desktop, you'll see changed files in the left panel
        3. Add a **Summary** (commit message) at the bottom
        4. Click **Commit to main**
        5. Click **Push origin** to upload

    === "Git Tower"

        #### Clone a Repository

        1. Open Git Tower
        2. **File → Clone** (or `Ctrl+Shift+C`)
        3. Paste the repository URL
        4. Choose where to save it
        5. Click **Clone**

        #### Make Your First Commit

        1. Make changes to files in your editor
        2. In Tower, go to the **Working Copy** view
        3. Stage files by clicking the **+** button
        4. Enter a commit message and click **Commit**
        5. Click **Push** to upload

---

## :fontawesome-solid-book: Quick Reference

--8<-- "includes/git-guide/_common-commands.md"

---

## :fontawesome-solid-circle-check: Checklist Summary

- [ ] GitHub account created
- [ ] Git installed
- [ ] GUI client installed
- [ ] SSH key created and added to GitHub
- [ ] Git identity configured
- [ ] Successfully cloned a repository
- [ ] Made your first commit

**Congratulations!** :tada: You're ready to use Git and GitHub.

*[GUI]: Graphical User Interface - Software with buttons and menus (like GitHub Desktop)
*[SSH]: Secure Shell - A secure method for logging into GitHub without typing your password every time