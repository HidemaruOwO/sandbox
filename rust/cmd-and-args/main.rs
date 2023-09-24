fn main() {
    let prefix = "!";
    let message_content = "!unko 1 2 3 4";

    if let Some(content) = message_content.strip_prefix(prefix) {
        let mut parts = content.split_whitespace();
        let cmd = parts.next().unwrap_or("");
        let args: Vec<_> = parts.collect();

        println!("Command: {}", cmd);
        println!("Arguments: {:?}", args);
    }
}
