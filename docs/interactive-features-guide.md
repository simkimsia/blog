---
title: Interactive Features Guide
description: How to enable comments and voting widgets on documentation pages
---

# Interactive Features Guide

This guide explains how to enable interactive features like Giscus comments and the anonymous voting widget on specific pages.

## Enabling Giscus Comments

To enable Giscus comments on a page, add `comments: true` to the page's YAML frontmatter.

**Example:**

```yaml
---
title: My Page Title
comments: true
---
```

**Configuration:**
Giscus configuration (Repo ID, Category ID) is managed in `overrides/partials/comments.html`.

## Adding the Voting Widget

To add the anonymous "Did this work for you?" voting widget, include the `voting_widget.md` partial at the desired location (usually at the bottom of the page).

**Syntax:**

```markdown
--8<-- "includes/voting_widget.md"
```

**Prerequisites:**
The voting widget requires a backend worker to store votes. Verify the `API_URL` setting in `includes/voting_widget.md`.
