# Standard Operating Procedure (SOP): Blog Maintenance

## 1. Generating Sitemap (SEO)
Updates `sitemap.yaml` with AI-generated summaries for new posts.

**Command:**
```bash
OPENAI_API_KEY=your-api-key-here uv run generate_sitemap.py
```
*Run when:* You add new markdown files or want to update summaries.

---

## 2. Generating Descriptions and Tags (SEO)
Auto-generates frontmatter descriptions, categories, and tags for new posts using AI.

**Command:**
```bash
OPENAI_API_KEY=your-api-key-here uv run generate_desc.py --api-key your-api-key-here
```
*Run when:* You have written a new blog post and want to auto-fill the metadata.

---

## 3. Checking Links
Scans all documentation for broken internal and external links.

**Command:**
```bash
uv run check_links.py
```
*Run when:* Before deploying changes or after moving files around. No API key required.
