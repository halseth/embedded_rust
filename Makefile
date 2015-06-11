default:
	rustc -C opt-level=2 -Z no-landing-pads --target thumbv6m-none-eabi -g --emit obj -L libcore-thumbv6m -o sum.o sum.rs

asm:
		rustc -C opt-level=2 -Z no-landing-pads --target thumbv6m-none-eabi -g --emit asm -L libcore-thumbv6m -o sum.o sum.rs

library:
	mkdir libcore-thumbv6m
	rustc -C opt-level=2 -Z no-landing-pads --target thumbv6m-none-eabi -g ../rust/src/libcore/lib.rs --out-dir libcore-thumbv6m

clean:
	rm *.o
