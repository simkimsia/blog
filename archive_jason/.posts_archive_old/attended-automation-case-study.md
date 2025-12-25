---
authors:
  - simkimsia
categories:
  - Applied AI
  - Automation
comments: true
date: 2025-12-16
description: How attended automation eliminated 80 hours of manual data entry for a non-profit by working with security constraints instead of against them.
draft: true
slug: attended-automation-case-study
tags:
  - Automation
  - Human-in-the-Loop
  - Non-Profit
  - Case Study
  - Python
---

# You Can Eliminate 80 Hours of Manual Labor Without Expensive Software

**The core insight:** When security constraints block standard automation, "attended automation" -- where humans handle authentication while machines handle extraction -- can deliver 160x efficiency gains without triggering anti-bot defenses.

Through my [automation consulting work](../../../services.md), I have seen this pattern repeatedly: organizations assume they need expensive enterprise software or complex workarounds to automate secured workflows. They don't. A targeted human-in-the-loop approach often works better and costs nothing to build.

This post walks through a real project where attended automation eliminated a two-week annual task for a Singapore-based non-profit -- and shows you how to apply the same pattern to your own secured data workflows.

<!-- more -->

**By the end of this post, you will understand:**

- When attended automation beats fully automated approaches
- The three-step pattern that respects security constraints
- How to estimate whether this approach fits your use case
- The specific technical architecture that made this work

## Key Terms

- **Attended Automation:** Human-initiated automation where a person handles authentication or exceptions while the machine handles repetitive extraction. The human "attends" the process at critical checkpoints.
- **Human-in-the-Loop (HITL):** Architecture design where human judgment is required at specific points, rather than full end-to-end automation.
- **Rate Limiting:** Intentionally slowing automated requests to respect server constraints and avoid IP bans or service disruption.
- **Anti-Bot Measures:** Security controls like CAPTCHAs, session timeouts, and behavioral analysis designed to prevent automated access.

## The Problem: 80 Hours of Annual Copy-Paste

A Singapore-based social impact organization needed Business Contact Information from a public industry directory for their annual fundraising outreach. The data existed, but accessing it meant clicking through hundreds of paginated result pages (50 records at a time) to manually extract contact information for over 9,000 entries.

Every year, the organization dedicated roughly two full-time staff or volunteers for an entire week -- approximately 80 person-hours -- to manually click, copy, and paste contact details into a spreadsheet.

The real cost was not just time. This "admin paralysis" burned out staff and delayed actual donor engagement work by weeks.

## Why Standard Automation Could Not Work

The organization had explored automation before. The problem: the target directory employed strict anti-bot measures.

- **CAPTCHAs** on login and at random intervals
- **Session timeouts** that invalidated access after periods of inactivity

A standard headless browser script would trigger these defenses immediately. The options seemed to be:

1. Pay for CAPTCHA-solving services (expensive, ethically questionable)
2. Accept the manual process as unavoidable

None of these were acceptable for a non-profit.

## The Attended Automation Pattern

Instead of trying to defeat the security measures, I designed a workflow that worked *with* them. The key insight: humans are good at authentication and exception handling; machines are good at repetitive extraction. Combine both.

### Step 1: Human-Attended Authentication

A volunteer uses their regular web browser to:

- Navigate to the directory and log in normally
- Solve the CAPTCHA
- Open Developer Tools (F12) and navigate to the Network tab
- Copy the session cookies from an authenticated request

This takes about 60 seconds and provides the authentication tokens the script needs. The volunteer then passes these cookies to the Python script via a configuration file.

### Step 2: Machine-Driven Extraction

Once the cookies are provided, the Python script takes over. It systematically:

- Makes authenticated HTTP requests to directory pages following a predictable URL pattern
- Extracts public business data (office address, general enquiry email)
- Writes records to a structured CSV in real-time
- Respects rate limits with configurable delays between requests

The script runs unattended after the initial authentication. If the session expires mid-run, the script logs the error and the volunteer can simply extract fresh cookies and restart from where it stopped.

### Step 3: Validation and Handoff

When extraction completes, the tool generates a summary: total records extracted, any pages that failed, and a preview of the data. The volunteer reviews this before the CSV is handed off to the outreach team.

### Technical Implementation

The stack was deliberately simple:

- **Python** for scripting
- **Requests library** for HTTP requests with session cookie authentication
- **CSV module** for output
- **LLM-assisted development** for rapid prototyping

This cookie-based approach is simpler than browser automation (no Selenium, no ChromeDriver, no browser process management). Using an LLM coding assistant, I went from problem diagnosis to working prototype in under 30 minutes. This matters for volunteer projects where development budget is zero -- the approach must be fast enough to justify the time investment.

**Design decision: No user interface.** When I asked the outreach manager how often this extraction ran, the answer was clear: once per year. For a task that runs annually, there is no justification for building a user-friendly interface, error recovery UI, or documentation for non-technical users. A technically-adept volunteer runs the script, validates the output, and hands off the CSV. This saved days of interface development that would have provided zero value.

## Outcomes: From 80 Hours to 30 Minutes

The organization ran their first automated extraction the same week the tool was delivered.

| Metric               | Before                                                                  | After                                                  |
| -------------------- | ----------------------------------------------------------------------- | ------------------------------------------------------ |
| Time to complete     | 80 person-hours                                                         | 30 minutes machine runtime + 5 minutes human oversight |
| Error rate           | Accidentally miss records when copy-pasting, formatting inconsistencies | Zero transcription errors                              |
| Volunteer allocation | 2 people for 1 week                                                     | 1 person for 1 hour (including setup and validation)   |

The freed volunteer capacity was redirected to donor engagement strategy -- work that actually benefits from human judgment and relationship skills.

## When to Use This Pattern

Attended automation is the right approach when:

**Security constraints exist but are not hostile.** The directory's anti-bot measures were designed to prevent server overload, not to block legitimate data access. Working with these constraints (rate limiting, human authentication) is both ethical and sustainable.

**The task is periodic, not continuous.** For a task that runs once a year, the overhead of attended setup (60 seconds of human time) is negligible. For tasks running every hour, you would need a different approach.

**Data volume is large but finite.** Thousands of records justify automation. Dozens of records do not. Millions of records might require infrastructure beyond a single browser session.

**The organization cannot afford enterprise solutions.** Commercial data extraction tools exist, but they cost money and often require ongoing subscriptions. For a volunteer-run non-profit, a custom Python script with zero licensing costs was the only viable option.

**Compliance matters.** By using legitimate authentication and respecting rate limits, the organization stayed within the directory's acceptable use. No terms of service were violated.

## When This Pattern Does Not Fit

Be honest about limitations:

- **Real-time or high-frequency needs:** If you need data refreshed hourly, attended automation creates too much human overhead.
- **Hostile anti-bot systems:** Some sites actively detect and block automation regardless of rate limiting. Attended automation will not help if the goal is to circumvent rather than comply.
- **Fully unattended requirements:** If no human can be present at launch time, you need a different architecture.

## Applying This to Your Workflows

If your team spends significant time on repetitive data extraction from secured systems, ask these diagnostic questions:

1. **What triggers the security measures?** Often it is headless browsers, rapid requests, or missing authentication -- not automation itself.
2. **Can a human handle the authentication checkpoint?** If yes, attended automation may work.
3. **Is the task periodic or continuous?** Periodic tasks are ideal candidates.
4. **What is the actual volume?** Calculate whether automation saves enough time to justify building it.

The 80-hour annual task in this case study was an obvious win. But I have heard of teams spending weeks building automation for tasks that take at most a couple hours per month. Match the investment to the payoff.

---

If your organization faces similar "data scrambles" -- annual, monthly, or weekly -- and you are not sure whether attended automation fits your specific constraints, I would be happy to discuss it. Sometimes a 30-minute conversation saves weeks of misguided effort in either direction.

[Get in touch about automation consulting](../../../services.md)
