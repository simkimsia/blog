# The Hidden Tax of AI Coding: Governance vs Generation

> **Working Title:** AI writes code fast, but it writes messy: How I tamed entropy in a Production App
> **Status:** Draft / Notes
> **Intended Audience:** CTOs, Engineering Managers, Founders using AI tools.

## The Hook: Speed vs. Coherence
I recently migrated a legacy system for a multi-national telco (Ericsson project). I used AI (Claude/Cursor) to accelerate the features.
*   **Speed:** Incredible. Features that took days took hours.
*   **Result:** A month later, I looked at my file handling code (SharePoint integration).
    *   Feature A (FLIR Reports) used `requests` directly in the View.
    *   Feature B (Billing) used a helper function in `utils.py`.
    *   Feature C (PO Tracker) used a method on the Model.
    *   **3 different logic paths. 3 different points of failure. 3x the maintenance surface.**

## The Diagnosis: Ticket-Based Intelligence
AI Tools (LLMs) solve the *Ticket*, not the *Repo*.
*   When I asked for "Feature A", it gave me the best way to do Feature A *in isolation*.
*   When I asked for "Feature B", it forgot about A (or I didn't remind it) and gave me a solution for B.
*   **Result:** High "Ticket Velocity", but massive "Architecture Drift".

## The "Fix": From Generator to Governor
I had to stop being a "Code Generator" and become an "AI Governor".
*   **The Refactor:** I didn't just "clean up code". I enforced a **Policy**.
*   **The Policy:** "The `V1CompatibleAttachment` Model is the Single Source of Truth for SharePoint paths. No View is allowed to construct a URL manually."
*   **The Shift:**
    *   **Before:** AI writes code. I check if it runs. Use it.
    *   **Now:** AI proposes code. I check if it *fits the patterns*. I reject 50% of working code because it introduces new patterns unnecessarily.

## The Consultant's Lesson (The "Product")
If you are deploying AI coding tools in your team:
1.  **Entropy will skyrocket.** AI produces "working legacy code" instantly.
2.  **Seniority matters more.** Juniors with AI generate technical debt at 10x speed. You need Seniors to act as *Editors* and *Architects*.
3.  **Governance is the new Coding.** The value I provided wasn't the API integration (the AI did that). The value was **restricting** the AI to a single, audit-proof path for file handling.

## Case Study Details (For the technical section, if needed)
*   **Problem:** Files ending up in random SharePoint folders because logic was scattered.
*   **Solution:** Centralized `download_from_sharepoint` and `upload_to_sharepoint` in the Django Model.
*   **Benefit:** Audit trail is now guaranteed. If the Model says it's downloaded, it's downloaded. No "oops, the view forgot to log it."

---
*Drafted on 2025-12-27. Context: Ericsson Migration Project Refactoring.*
