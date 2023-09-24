use reqwest::header;

#[tokio::main]
async fn main() {
    let token = "";
    let id = "1152588900947206176";
    let url = format!("https://discord.com/api/v10/guilds/{}", id);

    let client = reqwest::Client::new();
    let response = client
        .get(&url)
        .header(header::AUTHORIZATION, format!("{}", token))
        .send()
        .await
        .unwrap();

    if !response.status().is_success() {
        println!("Error: {}", response.status());
        return;
    }

    let guild: serde_json::Value = serde_json::from_str(&response.text().await.unwrap()).unwrap();

    println!("JSON {:?}", guild)
}
