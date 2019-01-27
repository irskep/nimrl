.PHONY: run

run:
	-killall main
	nim c -r \
		-d:glfwJustCdecl \
		-d:raynimCompile \
		--debugger:native \
		--out:bin/main src/main.nim # --verbosity:2