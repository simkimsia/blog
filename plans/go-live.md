# Go Live Plan

- [x] **Config**: Update `mkdocs.yml`
    - [x] `site_url`: `https://simkimsia.com`
    - [x] `repo_url`: `https://github.com/simkimsia/blog` (if different)
    - [x] `copyright`: Update to current year/owner
    - [x] Clean up `extra` links (Twitter, LinkedIn etc if outdated)
- [x] **CI/CD**: Create `.github/workflows/ci.yml`
    - [x] Use `actions/checkout`
    - [x] Use `actions/setup-python`
    - [x] Install `mkdocs-material` and plugins
    - [x] Deploy with `mkdocs gh-deploy`
- [x] **GitHub**: Settings -> Pages
    - [x] Source: `gh-pages` branch (after first run of CI)
    - [x] Custom Domain: `simkimsia.com`
    - [x] Enforce HTTPS: On
- [x] **DNS**: Configure at Cloudflare
    - [x] A records to GitHub Pages IPs
    - [x] CNAME for `www` (optional but recommended)
