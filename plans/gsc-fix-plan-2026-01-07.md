# Plan: Address Google Search Console Issues

## Overview

Based on the GSC report dated 2026-01-07, there are:

- **24 Duplicate without user-selected canonical** issues.
- **5 Not found (404)** issues.
- **4 Page with redirect** issues.

The blog uses **MkDocs Material**, which handles many SEO features automatically, but some manual configuration and best practices are missing.

## Proposed Changes

### 1. Add `robots.txt`

Currently, there is no `robots.txt` file. This is essential for guiding search engines and pointing them to the sitemap.

#### [CREATED] [robots.txt](file:///Users/kimsia/Projects/blog/docs/robots.txt)

```text
User-agent: *
Allow: /

Sitemap: https://simkimsia.com/sitemap.xml
```

### 2. Verify Canonical Tags

MkDocs Material generates canonical tags if `site_url` is set. It is already set to `https://simkimsia.com/` in `mkdocs.yml`. The 24 duplicates are likely due to Google finding variations (www, http, etc.). Once `robots.txt` and the sitemap are properly indexed, these should eventually resolve as Google prioritizes the canonical URL.

### 3. Fix 404 Errors (Image Links) [FIXED]

During local verification, I found that the **Git Installation & Setup Guide** had several broken image links due to incorrect relative paths in the included snippets.

- [x] Fixed `includes/git-guide/*.md` image paths.

### 4. Search Console Actions (User)

The following steps should be performed in the Google Search Console UI:

1. **Submit Sitemap**: Go to Indexing > Sitemaps and submit `https://simkimsia.com/sitemap.xml`.
2. **Inspect URLs**: Pick one of the "Duplicate" URLs and click "Inspect URL" to see which variation Google chose as the "Google-selected canonical" vs the "User-selected".

## Verification Plan

1. **Check robots.txt**: Visit `https://simkimsia.com/robots.txt` after deployment.
2. **Check sitemap.xml**: Visit `https://simkimsia.com/sitemap.xml` after deployment (MkDocs generates this automatically in the `site` folder).
3. **Validate SEO**: Use a tool like Lighthouse or simply view source on a live page to ensure `<link rel="canonical" ...>` exists and is correct.
