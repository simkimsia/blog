### Create SSH Key (Windows)

1. Open **Git Bash** and run:

    ```bash
    ssh-keygen -t ed25519 -C "your_email@example.com"
    ```

2. Press **Enter** to accept the default file location
3. Press **Enter** when asked for passphrase. You have to press **Enter** twice to confirm.

    --8<-- "includes/git-guide/_ssh-key-location-windows.md"

4. Start the SSH agent:

    ```bash
    eval "$(ssh-agent -s)"
    ```

5. Add your key to the agent:

    ```bash
    ssh-add ~/.ssh/id_ed25519
    ```

6. Copy your public key:

    ```bash
    Get-Content ~\.ssh\id_ed25519.pub | Set-Clipboard
    ```

    Your public key is now in your clipboard!
