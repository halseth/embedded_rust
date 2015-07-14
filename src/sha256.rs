#![feature(no_std)]
#![feature(core)]
#![feature(step_by)]
#![feature(core_slice_ext)]
#![feature(core_str_ext)]
#![feature(slice_bytes)]
#![feature(lang_items, libc, raw)]
#![feature(core_prelude)]
#![no_std]
#![crate_type="staticlib"]
// **************************************
// These are here just to make the linker happy
// These functions are just used for critical error handling so for now we just loop forever
// For more information see: https://github.com/rust-lang/rust/blob/master/src/doc/trpl/unsafe.md
#![feature(lang_items)]

extern crate core;

use core::prelude::*;
use core::slice::bytes::{MutableByteVector, copy_memory};
use core::mem;
use core::raw::Slice;

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
pub extern fn hash(src: *const u8, src_len: u32, dst: *mut u8, dst_len: u32) {
    if src.is_null() { return; }
    if dst.is_null() { return; }

    let (src_slice, dst_slice): (&[u8], &mut[u8]) = unsafe {
        mem::transmute((
            Slice { data: src, len: src_len as usize },
            Slice { data: dst, len: dst_len as usize },
        ))
    };

    dst_slice[1] = src_slice[0];
}
