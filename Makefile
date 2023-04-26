build: FORCE
	scarb build

clean: FORCE
	scarb clean

fmt: FORCE
	scarb fmt

test: FORCE
	cairo-test --starknet .

starknet-compile-sierra:
	mkdir -p out && \
	  starknet-compile -- ${file} out/$(shell basename $(file)).sierra

starknet-compile-json:
	mkdir -p out && \
	  starknet-compile -- ${file} out/$(shell basename $(file) .cairo).json

starknet-declare:
	starknet declare --contract ${file} --account version_2 --show_trace

starknet-deploy:
	starknet deploy --class_hash ${hash} --account version_2

starknet-status:
	starknet get_state_update
