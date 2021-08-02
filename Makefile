.PHONY: run run-with-slack run-api

run:
	stack build --exec ModraRuzeScraper-exe

run-with-slack:
	stack build --exec "ModraRuzeScraper-exe --notify-slack"

run-api:
	stack build --exec "ModraRuzeScraper-exe --notify-slack --api"