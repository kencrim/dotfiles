# 06-rust.zsh — Rust: Homebrew's rustup is keg-only, so its proxies (cargo,
# rustc, rustup) need adding to PATH; ~/.cargo/bin holds `cargo install`ed tools.
export PATH="/opt/homebrew/opt/rustup/bin:$HOME/.cargo/bin:$PATH"
