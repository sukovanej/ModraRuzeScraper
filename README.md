# ModraRuzeScraper

## Running (Powershell)

Set the slack API token

```powershell
$env:SLACK_API_TOKEN = "<token>"
$env:SLACK_CHANNEL = "<token>"
```

Run without notifying the slack channel (for testing the scraper only)

```powershell
make run
```

Run with the slack notification.

```powershell
make run-with-slack
```