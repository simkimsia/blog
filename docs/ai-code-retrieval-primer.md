---
categories:
- Software Engineering
description: Explore key articles on code retrieval systems tailored for coding workflows,
  emphasizing recall, embeddings, and rerankers.
tags:
- code retrieval
- embeddings
- rerankers
- software engineering
- AI
title: A Primer on Retrieval for Agentic Coding Workflows
---

# A Primer on Retrieval for Agentic Coding Workflows

A summary of key articles on modern code/text retrieval systems with a focus on coding workflows.

!!! abstract "What You'll Learn"
    - Why **recall > precision** for code retrieval
    - When to use embeddings vs. rerankers
    - Multi-vector search and quantization tricks
    - Which code embedding models to use

---

## Definitions

!!! info "Codebase Size Definitions"
    - **Small codebase:** ~50 items or fewer, where single-stage retrieval suffices ([Relace][relace])
    - **Large codebase:** 1000+ documents/files, where two-stage retrieval becomes necessary ([Relace][relace], [Pinecone][pinecone])
    - **Dynamic codebase:** One where code changes frequently, requiring frequent recomputation of embeddings for a large proportion of the codebase—making embedding pre-computation less cost-effective ([Relace][relace])

---

## :fontawesome-solid-magnifying-glass: The Core Problem

*Source: [Relace][relace]*

Frontier model performance degrades after ~50k tokens of context. Polluting context with irrelevant files makes generated code worse—and input tokens are expensive.

**The goal:** Minimize irrelevant tokens while maintaining near-perfect recall.

!!! tip "Recall > Precision"
    It's much worse to **miss** a relevant file than to include an extra irrelevant one. ([Relace][relace])

---

## :fontawesome-solid-bolt: Embeddings vs. Rerankers

*Source: [Relace][relace], [Pinecone][pinecone]*

| Aspect | Embeddings | Rerankers |
|--------|------------|-----------|
| How it works | Pre-compute k-dim vectors, compare with cosine similarity | Pass query + document together, output similarity score 0-1 |
| Speed | Fast (only embed query at runtime) | Slow (entire codebase per query) |
| Accuracy | Good | Better |
| Best for | Large codebases | Small, dynamic codebases |

!!! note "Why Rerankers for Dynamic Codebases?"
    For dynamic codebases that change frequently, embedding approaches require frequent recomputation of embeddings for a large proportion of the codebase, reducing cost savings. Rerankers avoid this overhead. ([Relace][relace])

### Two-Stage Retrieval (for large codebases)

*Source: [Pinecone][pinecone]*

1. **Fast pass:** regex, ripgrep, or embeddings → top 100 candidates
2. **Accurate pass:** reranker scores top 100 → final top K

---

## :fontawesome-solid-layer-group: Multi-Vector Search (ColBERT Approach)

*Source: [Isaac Flath / Mixedbread][mixedbread]*

Traditional single-vector search compresses too much—one embedding per chunk loses nuance.

**Multi-vector approach:**

- Instead of 1 vector per chunk → **1 vector per token**
- "I love bread" → 3 vectors instead of 1
- Preserves granular information
- Combines keyword precision (like BM25) with semantic understanding

!!! warning "Storage Trade-off"
    Vector per token = massive data. Solution: **Quantization**. ([HuggingFace][hf-quant])

### Quantization Techniques

*Source: [HuggingFace / Mixedbread][hf-quant]*

| Type | Compression | Speed Gain | Quality Loss |
|------|-------------|------------|--------------|
| Int8 | 4x smaller | ~3.7x faster | ~0% (with rescoring) |
| Binary (1-bit) | 32x smaller | ~25x faster (Hamming distance) | ~4-8% (with rescoring) |

**Mixedbread's trick:** Keep document vectors binary but query vectors at float32 → loss drops from ~7.5% to ~3.5%. ([HuggingFace][hf-quant])

### REFRAG: Context Compression for Decoding

*Source: [REFRAG Paper][refrag]*

!!! warning "REFRAG ≠ Retrieval"
    REFRAG optimizes **decoding** (LLM generation), not retrieval. It compresses *already-retrieved* passages before feeding to the decoder.

| Technique | How it works | Benefit |
|-----------|-------------|---------|
| **Chunk Embeddings** | Compress 16-token chunks into dense vectors | Shorter decoder input |
| **Selective Expansion** | RL policy expands only "important" chunks back to tokens | Preserves critical info |
| **Sparse Attention** | Retrieved passages often have block-diagonal attention (low cross-passage relevance) | Skip unnecessary computation |

**Results:** ~30x faster time-to-first-token, 16x context extension, no accuracy loss.

#### RL-based Selective Expansion

Not all chunks are equal. REFRAG uses reinforcement learning to decide which chunks to expand (keep full tokens) vs. compress:

- **Policy network** takes chunk embeddings as input, sequentially selects which to expand
- **Reward signal**: perplexity — lower = better meaning preservation
- **Dynamic rate**: compress more on easy passages, less on critical ones — no re-encoding needed

**Compression limits (from ablations):**

| Rate | Quality |
|------|---------|
| k=16 | Excellent — no loss |
| k=32 | Viable — slight drop |
| k=64 | Too aggressive — significant degradation |

#### REFRAG vs. ColBERT: Opposite Directions, Complementary Stages

| Approach | Direction | Stage | Goal |
|----------|-----------|-------|------|
| **ColBERT** | 1 token → many vectors | **Retrieval** | Better recall via granularity |
| **REFRAG** | many tokens → 1 vector | **Decoding** | Faster inference via compression |

These are **complementary**: use ColBERT to *find* the right files, then REFRAG to *process* them faster.

```
[Query] → [ColBERT Retrieval] → [Retrieved Passages] → [REFRAG Compression] → [LLM Decoder]
              expand for                                  compress for
              precise search                              fast generation
```

!!! note "Open Source"
    Official implementation: [`facebookresearch/refrag`](https://github.com/facebookresearch/refrag). Link seems broken as of 2025-12-30.

---

## :fontawesome-solid-code: Semantic Chunking

*Source: [Isaac Flath / Mixedbread][mixedbread]*

Different content types need different chunking strategies:

| Content Type | Chunking Strategy |
|--------------|-------------------|
| **Code** | Parse AST → group related functions/classes |
| **PDFs** | Screenshot pages → embed images |
| **Text** | Add surrounding context to each chunk ("late chunking") |

---

## :fontawesome-solid-robot: Code Embedding Models Compared

*Source: [Modal][modal]*

| Model | Parameters | Context | License | Key Strength |
|-------|------------|---------|---------|--------------|
| **VoyageCode3** | - | 32K | Proprietary | Best overall performance, 300+ languages |
| **OpenAI text-embedding-3-large** | - | 8K | Proprietary | Strong cross-domain, general + code |
| **Jina Code V2** | 137M | 8K | Apache 2.0 | Fast inference, good code search |
| **Nomic Embed Code** | 7B | 2K | Apache 2.0 | Fully open-source, strong cross-language |
| **CodeSage Large V2** | 1.3B | 2K | Apache 2.0 | Matryoshka dimensions, The Stack V2 trained |
| **CodeRankEmbed** | 137M | 8K | MIT | SOTA code retrieval, lightweight |

### Hosting Options

*Source: [Modal][modal]*

1. **Sentence Transformers:** Easy Python library, auto GPU, caching
2. **Text Embeddings Inference (TEI):** Rust-based, higher throughput, lower latency

---

## :fontawesome-solid-wand-magic-sparkles: Agentic Retrieval

*Source: [Jason Liu / Augment][augment]*

**Agentic retrieval** gives AI agents direct control over the search process using tools like grep, find, *and* embedding models—unlike traditional RAG which relies on a fixed embedding→vector search pipeline.

### When Grep/Find Suffices

For SWE-Bench, simple tools like `grep` and `find` beat embeddings because:

| Factor | Why grep/find worked |
|--------|---------------------|
| **Small repos** | Repositories were manageable in size |
| **Structured content** | Code has distinctive keywords (function names, imports) |
| **Agent persistence** | Agent could retry with different queries if initial search failed |
| **Simple tasks** | Solvable by a good engineer in under an hour |

### When Embeddings Become Essential

Embeddings become necessary when:

- **Large codebases** — millions of files make grep impractical
- **Unstructured content** — natural language docs lack distinctive keywords
- **Complex retrieval** — semantic understanding required (e.g., "find all authentication logic")

!!! tip "Hybrid Approach"
    Don't replace embeddings with agentic retrieval—**combine them**. Expose your embedding models as tools the agent can call alongside grep/find. This gives you agent persistence *plus* embedding quality. ([Jason Liu][augment])

---

## :fontawesome-solid-scale-balanced: Decision Framework

*Synthesized from all sources*

| Scenario | Recommendation | Source |
|----------|----------------|--------|
| Small corpus (~50 items) | Single-stage embedding retrieval is sufficient | [Relace][relace] |
| Large codebase (1000+ files) | Two-stage: fast pass + reranker | [Relace][relace], [Pinecone][pinecone] |
| Dynamic codebase (frequent changes) | Reranker-only (avoids re-embedding overhead) | [Relace][relace] |
| Mixed content (code + natural language) | Nomic Embed Code or VoyageCode3 | [Modal][modal] |
| On-prem deployment | Nomic Embed Code (Apache 2.0) | [Modal][modal] |
| Cloud/SaaS | VoyageCode3 (SOTA but paid) | [Modal][modal] |
| Storage constraints | Int8 quantization (~0% quality loss) | [HuggingFace][hf-quant] |

---

## :fontawesome-solid-book: References

[relace]: https://www.relace.ai/blog/code-retrieval "Relace: SoTA Code Retrieval"
[mixedbread]: https://elite-ai-assisted-coding.dev/p/most-rag-systems-have-a-context-problem "Isaac Flath: Most RAG Systems Have a Context Problem"
[modal]: https://modal.com/blog/6-best-code-embedding-models-compared "Modal: 6 Best Code Embedding Models"
[pinecone]: https://www.pinecone.io/learn/series/rag/rerankers/ "Pinecone: Rerankers in RAG"
[hf-quant]: https://huggingface.co/blog/embedding-quantization "HuggingFace: Embedding Quantization"
[augment]: https://jxnl.co/writing/2025/09/11/why-grep-beat-embeddings-in-our-swe-bench-agent-lessons-from-augment/ "Jason Liu: Why Grep Beat Embeddings"
[refrag]: https://arxiv.org/abs/2509.01092 "REFRAG: Rethinking RAG based Decoding"

- [Relace: SoTA Code Retrieval][relace]
- [Isaac Flath: Most RAG Systems Have a Context Problem][mixedbread]
- [Modal: 6 Best Code Embedding Models Compared][modal]
- [Pinecone: Rerankers in RAG][pinecone]
- [HuggingFace / Mixedbread: Embedding Quantization][hf-quant]
- [Jason Liu / Augment: Why Grep Beat Embeddings][augment]
- [REFRAG: Rethinking RAG based Decoding (arXiv)][refrag]