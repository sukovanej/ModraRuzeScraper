.PHONY: run

run:
	stack build --exec ModraRuzeScraper-exe


run-with-slack:
	stack build --exec "ModraRuzeScraper-exe --notify-slack"