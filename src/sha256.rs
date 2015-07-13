#![feature(no_std)]
#![feature(core)]
#![feature(step_by)]
#![feature(core_slice_ext)]
#![feature(core_str_ext)]
#![feature(slice_bytes)]
#![no_std]
#![crate_type="staticlib"]
// **************************************
// These are here just to make the linker happy
// These functions are just used for critical error handling so for now we just loop forever
// For more information see: https://github.com/rust-lang/rust/blob/master/src/doc/trpl/unsafe.md
#![feature(lang_items)]

extern crate core;

use core::ops::FnMut;
use core::slice::SliceExt;
use core::slice::bytes::{MutableByteVector, copy_memory};
use core::str::StrExt;

#[lang="stack_exhausted"] extern fn stack_exhausted() {}
#[lang="eh_personality"] extern fn eh_personality() {}

#[lang="panic_fmt"]
pub fn panic_fmt(_fmt: &core::fmt::Arguments, _file_line: &(&'static str, usize)) -> ! {
    loop { }
}

// **************************************
// **************************************
// And now we can write some Rust!

#[no_mangle]
pub extern fn hash(src: *const [u8; 64], dst: *mut [u8; 64]) {
    if src.is_null() { return; }
    if dst.is_null() { return; }

    // Convert to borrowed pointers.
    let src: &[u8; 64] = unsafe { &*src };
    let dst: &mut [u8; 64] = unsafe { &mut *dst };

    dst[0] = src[0];
    dst[1] = src[1];
    dst[2] = src[2];
    dst[3] = src[3];
}
