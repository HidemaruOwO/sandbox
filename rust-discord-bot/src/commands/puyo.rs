use serenity::framework::standard::{macros::command, CommandResult};
use serenity::model::prelude::*;
use serenity::prelude::*;

#[command]
#[description = "ぷよと発言します"]
async fn puyo(ctx: &Context, message: &Message) -> CommandResult {
    message
        .channel_id
        .say(&ctx.http, format!("{} ぷよ", message.author.mention()))
        .await?;

    Ok(())
}
