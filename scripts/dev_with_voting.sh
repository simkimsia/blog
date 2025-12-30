#!/bin/bash
echo "Starting Mock Voting API..."
python scripts/mock_voting_api.py &
API_PID=$!

echo "Starting MkDocs Server..."
mkdocs serve --watch includes --watch overrides

# When mkdocs serve stops, kill the API server
kill $API_PID
