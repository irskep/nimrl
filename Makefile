.PHONY: run

run:
	-killall main
	nimble c -r src/main.nim