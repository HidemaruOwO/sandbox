mod version;
use version::*;

fn main() {
    println!("Cargo version: {}", cargo_version());
    println!("Rustc version: {}", rustc_version());
}
