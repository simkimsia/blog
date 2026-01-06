### Configure Git Identity

Tell Git who you are (use the same email as your GitHub account):

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

Verify your settings:

```bash
git config --global --list
```

!!! tip "Per-project config"
    Omit `--global` to set identity for a specific repository only.

![Configure Git Identity](images/git-guide/configure-git.png)
