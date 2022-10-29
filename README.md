# Enjoy!BBQ!

## サイト概要
BBQ向けレシピを共有するコミュニティサイト
### サイトテーマ
BBQ初心者、上級者、BBQに興味のある方皆さんがさらに楽しめるように、レシピを共有できるサイトとなっています。
レシピ閲覧、投稿、いいね、フォロー機能等を実装し、情報が欲しい人も発信したい人も楽しめるサイトとなっています。

### テーマを選んだ理由
私はBBQが好きで、友人や家族と楽しむこともあれば一人で楽しむこともあります。回数も重ね、ただ食材を焼くだけでなく、燻製やBBQで楽しめる飲み物にも関心を持つようになりました。

個人で楽しんでいるだけでも十分満足だったのですが、ある時、友人から、BBQでやって良かったことを教えて欲しいと聞かれたことがありました。曰く、ネットで調べてみてもハードルが高かったり、そもそも情報が仕入れづらかったりするとのことで、一人で楽しむこともあって手軽そうなやり方を知っているのではないかと思い、私に尋ねたそうです。

アウトドアが流行している昨今ですが、流行している分、敷居が高い面もあります。誰もが自分なりのBBQを楽しむことができる、手軽なコミュニティがあったらいいなと思い、作るに至りました。
上級者も初心者も、誰もがBBQを楽しむことができる一助となれれば幸いです。Enjoy!BBQ!

### ターゲットユーザー
* BBQのレシピを発信したい人
* BBQのレシピを知りたい人

### 主な利用シーン
* BBQでやってみたいことを探したい。
* BBQでやってきたことをアウトプットも兼ねて発信したい。

## サイトイメージ
![Enjoy!BBQ!](https://user-images.githubusercontent.com/109708488/198795023-1a5d8ac0-88a0-427d-b2a9-9c2bbcd2bae8.gif)

## レスポンシブ対応
![レスポンシブ 001](https://user-images.githubusercontent.com/109708488/198799180-1d745bb2-fea1-4c9f-8206-b14a6d290f2f.jpeg)

## 設計書
* [Enjoy_BBQ!ER図 drawio](https://user-images.githubusercontent.com/109708488/196321353-211c2fdf-c651-4639-a935-0955cc95bc6d.png)
* [テーブル定義書](https://docs.google.com/spreadsheets/d/1ufuXAlIx3xl8uH_KpReC5UO0zKuAB3Oqp9wF9wfACEo/edit?usp=sharing)
* [アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1DeBXTaj3FzvqEp6QNo2siHBz9x6ktFSt/edit?usp=sharing&ouid=109420515576489920690&rtpof=true&sd=true)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
## gem一覧
#### デバック
* gem 'pry-byebug'
* gem 'pry-doc'
* gem 'pry-rails'
#### ログイン機能
* gem 'devise'
#### レイアウト
* gem 'image_processing', '~> 1.2'
* gem 'bootstrap5-kaminari-views', '~> 0.0.1'
#### 動的フォーム実装機能
* gem 'cocoon'
#### ページネーション
* gem 'kaminari','~> 1.2.1'
#### 検索機能
* gem 'ransack'
#### デプロイ
* gem 'mysql2'
#### その他
* gem 'enum_help'
* gem "rails-i18n"
