#### Check for Existing SSH Keys (macOS)

Open your terminal and run:

```bash
ls -la ~/.ssh
```

Look for files named `id_ed25519` or `id_rsa` (and their `.pub` counterparts).

- **Found keys?** You can use your existing key — skip to [5c. Add SSH Key to GitHub](#5c-add-ssh-key-to-github)
- **No keys or want a fresh one?** Continue to "5b. Create SSH Key"
