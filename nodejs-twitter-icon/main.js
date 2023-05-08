const { Builder, By, Key, until } = require('selenium-webdriver');
const chrome = require('selenium-webdriver/chrome');
const options = new chrome.Options();

async function main() {
  // 引数を取得する
  const args = process.argv;
  // 第1引数がユーザーIDであることを前提として、1番目の引数をuser_idとして取得する
  const user_id = args[2];

  // ブラウザを起動する
  const driver = new Builder().forBrowser('chrome').setChromeOptions(options).build();

  // Twitterのプロフィールページにアクセスする
  await driver.get(`https://twitter.com/${user_id}/photo`);

  // 要素が表示されるまで待つ
  const icon = await driver.wait(until.elementLocated(By.css('img.css-9pa8cd')), 10000);

  // JavaScriptを実行してアイコンのURLを取得する
  const icon_url = await driver.executeScript("return arguments[0].src;", icon);

  // ブラウザを終了する
  await driver.quit();

  console.log(icon_url);
}

main();

