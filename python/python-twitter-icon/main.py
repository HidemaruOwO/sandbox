from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import sys

# 引数を取得する
args = sys.argv

# 第1引数がユーザーIDであることを前提として、1番目の引数をuser_idとして取得する
user_id = args[1]

# ブラウザを起動する
driver = webdriver.Chrome()

# Twitterのプロフィールページにアクセスする
driver.get(f'https://twitter.com/{user_id}/photo')

# 要素が表示されるまで待つ
wait = WebDriverWait(driver, 10)
icon = wait.until(EC.presence_of_element_located(
    (By.CSS_SELECTOR, "img.css-9pa8cd")))

# JavaScriptを実行してアイコンのURLを取得する
icon_url = driver.execute_script("return arguments[0].src;", icon)

# ブラウザを終了する
driver.quit()

print(icon_url)
