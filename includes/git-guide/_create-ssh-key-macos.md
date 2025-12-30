### Create SSH Key (macOS)

1. Open Terminal and run:

    ```bash
    ssh-keygen -t ed25519 -C "your_email@example.com"
    ```

2. Press **Enter** to accept the default file location
3. Press **Enter** when asked for passphrase. You have to press **Enter** twice to confirm.

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
    pbcopy < ~/.ssh/id_ed25519.pub
    ```

    Your public key is now in your clipboard!
