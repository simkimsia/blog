#### Check for Existing SSH Keys (Windows)

Open your terminal and run:

In Git Bash:

```bash
ls -la ~/.ssh
```

Look for files named `id_ed25519` or `id_rsa` (and their `.pub` counterparts).

- **Found keys?** You can use your existing key — skip to "Add SSH Key to GitHub"
- **No keys or want a fresh one?** Continue to "5b. Create a New SSH Key"
