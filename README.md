

# photoApp
this is private repository. do not make it public.

# thinking
- instagram
- flicker
- pixiv
- あくまでも課題設定の方が重要なので、実装は最低限で負担なく。企業もそれに関しては求めていない。
- lightに考える
- ユーザーのどのような課題を解決しているか？
- なるべくアニメとかそういう系のapiを利用したい
- [pixivは生のapi無い](https://devpixiv.hatenablog.com/entry/2016/11/30/133612)

# persona
- 女子大生
- アニオタ
- 推しキャラがいっぱいいて、pixivやtwitterなどで推しの画像をブックマークしている
- しかしブックマークはひとつしかないため、キャラがごちゃまぜになってしまい、あとで見返す時に見づらい。
- ブックマークを複数作成することができれば便利
  - さらにいうとフォルダ構造で作成することができれば、アニメごとで分けるなどができて便利

# future work
- リストをシェアすることで、推しを友達に見せびらかす
- 選択してダウンロード

# cites
- https://qiita.com/ukandori/items/234156f97eb6dad77966
- https://qiita.com/takasek/items/3f727f976e27daf00309

# 学んだこと
- google画像検索apiの使い方
- ちゃんとエラー文見る
- データソース忘れない
- cellForItemAtとnumberOfItemsInSectionだけだとこんな感じになる。1行に収めるように縮小するって感じかな。
![simulator_screenshot_257877B4-9267-4AEF-9![Uploading simulator_screenshot_9A6D78D6-9867-4A30-8EFD-FB637D23EA9B.png…]()
EFA-5B7A61329937](https://user-images.githubusercontent.com/60727025/174429370-5a0e2426-66a7-4edc-a9c8-a0f4d11aecd5.png)
- サンプルアプリ大量に作ることがiOSマスターへの道になる気がする。サンプルアプリを参照して開発をする。これは楽天でも言えること
- UIの更新処理はメインスレッドで行う。

<!---


# photoApp
this is private repository. do not make it public.

# thinking
- instagram
- flicker
- pixiv
- あくまでも課題設定の方が重要なので、実装は最低限で負担なく。企業もそれに関しては求めていない。

# ペルソナ
- 大学生
- 趣味
  - 料理
  - 古着
  - 地下アイドル
- インスタグラムのユーザーで、趣味それぞれに関するアカウントをフォローしている。
- 普段は左下のおすすめ欄でタイムラインをみている。
- しかし趣味がごちゃまぜの状態になっているため、「料理だけ」や「古着だけ」をみたいケースにおいて不便である。
- だから「料理垢」、「古着垢」みたいな感じで分けたりする。
- そこでtabのようなものを用意することで、瞬時にタイムラインの切り替えができるようにする
- それのブックマーク版を作る。

- ハッシュタグとの差別化
  - 複数のハッシュタグで検索をすることができる
  - 設定として保持するため、いちいち入力する必要がなくなる

# めも
- ハッシュタグでのタブ分け
- ユーザーごとでタブ分け
- これに関してはtwitterにリストっていう機能があったな
