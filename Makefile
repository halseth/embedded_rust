default:
	rustc -C opt-level=2 -Z no-landing-pads --target thumbv6m-none-eabi -g --emit obj -L libcore-thumbv6m -o main.o main.rs