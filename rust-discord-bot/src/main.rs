mod commands;

use std::{collections::HashSet, fs::File, io::BufReader, usize};

use serenity::async_trait;

// コマンドの定義
use serenity::framework::standard::{
    help_commands,
    macros::{group, help},
    Args, CommandGroup, CommandResult, HelpOptions,
};

use serenity::framework::StandardFramework;
// 保存するものの定義
use serenity::model::{channel::Message, gateway::Ready, id::UserId};
use serenity::prelude::{Client, Context, EventHandler, GatewayIntents};

use serde::{Deserialize, Serialize};
use serde_json::Result;

use commands::puyo::*;
#[group]
#[description("一般コマンド")]
#[summary("general")]
#[commands(puyo)]
struct General;

#[derive(Serialize, Deserialize)]
struct Token {
    token: String,
}

fn get_token(file_name: &str) -> Result<String> {
    let file = File::open(file_name).unwrap();
    let reader = BufReader::new(file);
    let t: Token = serde_json::from_reader(reader).unwrap();
    Ok(t.token)
}

struct Handler;

//Rustにはトレイとのメッソどに、#[async_trait]マクロを用意しないと、トレイトを非同期で実行できない
#[async_trait]
impl EventHandler for Handler {
    async fn ready(&self, _: Context, ready: Ready) {
        println!("{} is readyed!!", ready.user.name);
    }
}

#[help]
#[individual_command_tip = "コマンドの一覧を表示します"] //コマンドの説明
#[strikethrough_commands_tip_in_guild = ""] //しようできないコマンドの削除
async fn help_command(
    ctx: &Context,
    message: &Message,
    args: Args,
    help_options: &'static HelpOptions,
    groups: &[&'static CommandGroup],
    owners: HashSet<UserId>,
) -> CommandResult {
    let _ = help_commands::with_embeds(ctx, message, args, help_options, groups, owners).await;
    Ok(())
}

#[tokio::main]
async fn main() {
    // Discord Bot Token を設定
    let token = get_token("config.json").expect("Err トークンが見つかりません");
    // コマンド系の設定
    let framework = StandardFramework::new()
        // |c| c はラムダ式
        .configure(|c| c.prefix(":")) // コマンドプレフィックス
        .help(&HELP_COMMAND) // ヘルプコマンドを追加
        .group(&GENERAL_GROUP); // general を追加するには,GENERAL_GROUP とグループ名をすべて大文字にする

    // Intentsの定義
    let intents = GatewayIntents::non_privileged() | GatewayIntents::MESSAGE_CONTENT;

    // Botのクライアントを作成
    let mut client = Client::builder(&token, intents)
        .event_handler(Handler) // 取得するイベント
        .framework(framework) // コマンドを登録
        .await
        .expect("Err creating client"); // エラーハンドリング

    // メインループ．Botを起動
    if let Err(why) = client.start().await {
        println!("Client error: {:?}", why);
    }
}
