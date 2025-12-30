
1. Go to [github.com/settings/keys](https://github.com/settings/keys){: target="_blank" }
2. Click **New SSH key**
3. Give it a **Title** (e.g., "My MacBook" or "Work Laptop")
4. Paste your public key into the **Key** field
5. Click **Add SSH key**

**Test the connection:**

```bash
ssh -T git@github.com
```

You should see:

```
Hi username! You've successfully authenticated...
```

!!! warning "First connection"
    On first connection, you'll be asked to verify GitHub's fingerprint. Type `yes`, then press `Enter` to continue.

    ![Verify GitHub Fingerprint](../../images/git-guide/type-yes-fingerprint.png)

If you see `Hi username! You've successfully authenticated, but GitHub does not provide shell access.`, then proceed to [Step 6](#step-6-configure-git-identity).
