# embedded_rust
Rust on nRF51822 (ARM Cortex-M0)

# Instructions:
* clone the rust git repo into ../rust
* create libcore by running
```
make library
```
* compile sum.rs by running 
```
make
```
link sum.o into your C-project, and access using the signature
```
extern int32_t sum(int32_t a, int32_t b);
```
