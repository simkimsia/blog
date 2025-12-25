<style>
  .voting-container {
    border: 1px solid var(--md-default-fg-color--lightest);
    border-radius: 0.5rem;
    padding: 1rem;
    margin-top: 2rem;
    margin-bottom: 2rem;
    font-family: var(--md-text-font-family);
  }
  .voting-title {
    font-weight: bold;
    margin-bottom: 1rem;
    display: block;
  }
  .voting-area {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    margin-bottom: 1rem;
  }
  .vote-card {
    border: 1px solid var(--md-default-fg-color--lightest);
    border-radius: 0.5rem;
    padding: 1rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start; /* Align content to the top */
    flex: 1;
    min-width: 150px;
    background-color: var(--md-default-bg-color);
  }
  .vote-card .card-text {
    margin-bottom: 0.5rem; /* Consistent spacing */
    height: 1.5em; /* Ensure consistent height for text line */
    display: flex;
    align-items: center;
  }
  .vote-buttons {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 0.5rem;
  }
  .vote-btn {
    border: 1px solid var(--md-default-fg-color--lightest);
    background: transparent;
    cursor: pointer;
    padding: 0.5rem 1rem;
    border-radius: 0.25rem;
    font-size: 1rem;
    transition: background-color 0.2s;
    color: var(--md-text-color);
    text-decoration: none;
    text-align: center;
    min-width: 100px; /* Give buttons a consistent minimum width */
  }
  .vote-btn:hover {
    background-color: var(--md-default-fg-color--lightest);
  }
  .vote-subtext {
    font-size: 0.75rem;
    color: var(--md-default-fg-color--light);
  }
  .vote-counts-display {
    font-size: 0.85rem;
    color: var(--md-default-fg-color--light);
    border-top: 1px solid var(--md-default-fg-color--lightest);
    padding-top: 0.5rem;
  }
</style>

<div class="voting-container">
  <span class="voting-title">Did this work for you?</span>

  <div class="voting-area">
    <!-- Anonymous Voting -->
    <div class="vote-card">
      <div class="card-text">
        Casual user?
      </div>
      <div class="vote-buttons">
        <button class="vote-btn" onclick="submitVote('yes')">👍 Yes</button>
      </div>
    </div>

    <!-- GitHub Link -->
    <div class="vote-card">
       <div class="card-text">
         Power user?
       </div>
       <a href="#__comments" class="vote-btn">
         👍 on reactions
       </a>
    </div>
  </div>

  <div class="vote-counts-display">
    <span id="combined-vote-message">--</span>
  </div>
</div>

<script>
  // Simple check for local development
  const API_URL = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
    ? 'http://localhost:8787'
    : 'https://replace-me-with-real-worker-url.com';

  const slug = window.location.pathname;

  // State to hold counts from both sources
  let counts = {
    anon: 0,
    github: 0
  };

  function renderTotal() {
    const total = counts.anon + counts.github;
    const el = document.getElementById('combined-vote-message');

    if (total === 0) {
      el.innerText = "Be the first to find this helpful";
    } else if (total === 1) {
      el.innerText = "1 person finds this helpful";
    } else {
      el.innerText = `${total} people find this helpful`;
    }
  }

  async function fetchAnonVotes() {
    try {
      const res = await fetch(`${API_URL}/votes?slug=${encodeURIComponent(slug)}`);
      if (res.ok) {
        const data = await res.json();
        counts.anon = data.yes || 0;
        renderTotal();
      }
    } catch (e) {
      console.error('Error fetching votes:', e);
    }
  }

  async function submitVote(type) {
    try {
      const res = await fetch(`${API_URL}/vote`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ slug, type })
      });
      if (res.ok) {
        const data = await res.json();
        counts.anon = data.yes;
        renderTotal();
      }
    } catch (e) {
      console.error('Error submitting vote:', e);
    }
  }

  // Listen for Giscus metadata messages
  window.addEventListener('message', function(event) {
    if (event.origin !== 'https://giscus.app') return;
    if (!(event.data && event.data.giscus && event.data.giscus.discussion)) return;

    const discussion = event.data.giscus.discussion;
    // reactionCount includes all reactions (thumbs up, heart, etc.)
    if (typeof discussion.reactionCount !== 'undefined') {
        counts.github = discussion.reactionCount;
        renderTotal();
    }
  });

  // Fetch on load
  if (API_URL) {
      fetchAnonVotes();
  }
</script>
