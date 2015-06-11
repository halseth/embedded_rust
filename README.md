# embedded_rust
Rust on nRF51822 (ARM Cortex-M0)

# Instructions:
NB: Use newest nightly! Tested on 1.2.0 nightly

* find the commithash of your rustc by running
```
rustc -v --version
```
* clone the rust git repo into ../rust
* cd to rust directory and checkout the commithash you found
```
git checkout <commithash>
```
* cd to embedded_rust directory and create libcore by running
```
make library
```
* compile sum.rs by running 
```
make
```
* link sum.o into your C-project, and access using the signature
```
extern int32_t sum(int32_t a, int32_t b);
```
