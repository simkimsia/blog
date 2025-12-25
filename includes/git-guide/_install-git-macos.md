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

The simplest way — no extra software needed:

```bash
xcode-select --install
```

A popup will appear — click **Install** and wait for completion (may take a few minutes).

---

#### Verify Installation

```bash
git --version
```

You should see something like `git version 2.39.0`.
