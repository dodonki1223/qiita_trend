# QiitaTrend

[![Gem Version](https://badge.fury.io/rb/qiita_trend.svg)](https://badge.fury.io/rb/qiita_trend) [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/dodonki1223/qiita_trend/blob/master/LICENSE.txt) [![CircleCI](https://circleci.com/gh/dodonki1223/qiita_trend/tree/master.svg?style=svg)](https://circleci.com/gh/dodonki1223/qiita_trend/tree/master)

Qiitaのトレンドを10秒で取得することができます

![01_qiita_trend](https://raw.githubusercontent.com/dodonki1223/image_garage/master/qiita_trend/01_qiita_trend.gif)

## 概要

- [Qiita](https://qiita.com/)のTOPページをスクレイピングしTOPページに表示されているトレンドを取得します
  - [Qiita](https://qiita.com/)のAPIにトレンドを取得する方法がないため
- トレンドは「通常のもの（通常トレンド）」と「ログインした時に表示されるユーザーのトレンド（ユーザートレンド）」のそれぞれを日付と更新時間（5時と17時）の組み合わせごとにキャッシュを行います
- ユーザートレンドに関してはQiitaにログインしないと取得できないためユーザー名とパスワード設定する必要があります（通常トレンドに関しては何も設定しなくても取得できます）
- 過去のトレンドを取得することができます（**あくまでもキャッシュファイルから復元するためキャッシュファイルの無い過去のトレンドは取得することができません**）
- いいね数は性質上取得した時の時間に依存します。どうしても現在時刻のいいね数が欲しい場合はキャシュファイルを手動で削除してもう一度実行してください

## ドキュメント

[RubyDoc.info](https://rubydoc.info/github/dodonki1223/qiita_trend)

## 使用方法

`gem install qiita_trend`を実行する

```shell
$ gem install qiita_trend
```

### Qiitaの通常トレンドを10秒で取得する

ターミナルで`ruby -r qiita_trend -e "pp QiitaTrend::Trend.new.items"`を実行することでQiitaのトレンドを10秒（**gem install qiita_trendも含めて**）で取得できます  

```shell
$ ruby -r qiita_trend -e "pp QiitaTrend::Trend.new.items"
[{"title"=>"2行でwebpack.config.jsで補完を効かせる方法",
  "user_name"=>"akameco",
  "user_image"=>
   "https://qiita-image-store.s3.amazonaws.com/0/15319/profile-images/1473684249",
  "user_page"=>"https://qiita.com/akameco",
  "article"=>"https://qiita.com/akameco/items/e12377e55e379d29636e",
  "published_at"=>"2019-08-05T01:17:34Z",
  "likes_count"=>158,
  "is_new_arrival"=>false},
 {"title"=>"Excelで誰でも簡単言語処理 (感情推定, 固有表現抽出, キーワード抽出,  文類似度推定 etc...)",
  "user_name"=>"Harusugi",
  "user_image"=>"https://avatars2.githubusercontent.com/u/19549989?v=4",
  "user_page"=>"https://qiita.com/Harusugi",
  "article"=>"https://qiita.com/Harusugi/items/535874c0456dbc4db231",
  "published_at"=>"2019-08-04T23:01:22Z",
  "likes_count"=>103,
  "is_new_arrival"=>false},
  ...
```

### 通常トレンドの簡易表示

index + タイトル名 + いいね数 + ユーザー名

```shell
$ ruby -r qiita_trend -e "QiitaTrend::Trend.new.items.each_with_index {|t, i| puts '[' + i.to_s + ']' + t['title'] + '(' + t['likes_count'].to_s + ')' + ' - ' + t['user_name']}"

[0]2行でwebpack.config.jsで補完を効かせる方法(158) - akameco
[1]Excelで誰でも簡単言語処理 (感情推定, 固有表現抽出, キーワード抽出,  文類似度推定 etc...)(103) - Harusugi
[2]コミュニケーション能力についてTwitterで打ち明けたら解決の糸口が見つかった話(109) - cyross4vocaloid
[3]畑に農作物を植えてみたけど、忙しくて毎日水やりにいけないのに日照り続きでどうしたものかと悩んでいたら、自動で散水する方法を思いついて試してみたという話(86) - mix_dvd
[4]KAGGLEでどこから手を付けていいか分からず学ぶことが多すぎてまとめてみた(89) - aokikenichi
[5]畳み込みニューラルネットワークは何を見ているか(69) - okn-yu
```

### 通常トレンドのタイトル一覧

```shell
$ ruby -r qiita_trend -e "QiitaTrend::Trend.new.items.each {|t| puts t['title']}"

2行でwebpack.config.jsで補完を効かせる方法
Excelで誰でも簡単言語処理 (感情推定, 固有表現抽出, キーワード抽出,  文類似度推定 etc...)
コミュニケーション能力についてTwitterで打ち明けたら解決の糸口が見つかった話
畑に農作物を植えてみたけど、忙しくて毎日水やりにいけないのに日照り続きでどうしたものかと悩んでいたら、自動で散水する方法を思いついて試してみたという話
KAGGLEでどこから手を付けていいか分からず学ぶことが多すぎてまとめてみた
畳み込みニューラルネットワークは何を見ているか
```

### 通常トレンドのうち`new`がついているものをブラウザで一括で開く

```shell
$ ruby -r qiita_trend -e "QiitaTrend::Trend.new.new_items.each {|t| system('open ' + t['article'])}"
```

## 自分のプロジェクトで使用する

Gemfileにqiita_trendを追加する

```ruby
gem 'qiita_trend'
```

Gemfileに追加したら`bundle install`してください

### 通常トレンドを取得する

```ruby
normal_trend = QiitaTrend::Trend.new

# 通常トレンドを全て取得する
p normal_trend.items

# 通常トレンドでNEWのものだけを取得する
p normal_trend.new_items
```

### ユーザートレンドを取得する

ユーザートレンドを取得する時はQiitaにログインしている必要があるため、ログイン出来るユーザーとパスワードの設定が必要です
ログインできないユーザー名とパスワードを指定している時は`LoginFailureError`の例外が発生します

```ruby
# Qiitaにログインするためのユーザーとパスワードの設定をする
QiitaTrend.configure do |config|
  config.user_name = 'ユーザー名'
  config.password = 'パスワード'
end

# ユーザーのレンドを取得
personal_trend = QiitaTrend::Trend.new(QiitaTrend::TrendType::PERSONAL)
p personal_trend.items
```

ログインするユーザーとパスワードは環境変数に設定することもできます

```
export QIITA_TREND_USER_NAME='ユーザー名'
export QIITA_TREND_PASSWORD='パスワード'
```

### キャッシュファイルからトレンドを取得する

キャッシュファイルが存在しない場合は`NotExistsCacheError`の例外が発生します
ユーザートレンドの取得方法も通常トレンドと同様です

```ruby
# 2019年8月8日5時更新分の通常トレンドを取得する
normal_trend_05 = QiitaTrend::Trend.new(QiitaTrend::TrendType::NORMAL, '2019080805')

p normal_trend_05.items
p normal_trend_05.new_items

# 2019年8月8日17時更新分のnormalのトレンドを取得する
normal_trend_17 = QiitaTrend::Trend.new(QiitaTrend::TrendType::NORMAL, '2019080817')

p normal_trend_17.items
p normal_trend_17.new_items
```

### itemsメソッド、new_itemsメソッドについて

itemsメソッド、new_itemsメソッドは`Array`を返します
Array一つ一つは`Hash`になります

```shell
irb(main):002:0> QiitaTrend::Trend.new.items.class
=> Array
irb(main):003:0> QiitaTrend::Trend.new.items[0].class
=> Hash
```

Hashは以下の構成になっています

```shell
irb(main):001:0> pp QiitaTrend::Trend.new.items[0]
{"title"=>"2行でwebpack.config.jsで補完を効かせる方法",
 "user_name"=>"akameco",
 "user_image"=>
  "https://qiita-image-store.s3.amazonaws.com/0/15319/profile-images/1473684249",
 "user_page"=>"https://qiita.com/akameco",
 "article"=>"https://qiita.com/akameco/items/e12377e55e379d29636e",
 "published_at"=>"2019-08-05T01:17:34Z",
 "likes_count"=>158,
 "is_new_arrival"=>false}
```

<table>
  <thead>
    <tr>
      <th>key</th>
      <th>内容</th>
      <th>備考</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>title</td>
      <td>記事タイトル</td>
      <td></td>
    </tr>
    <tr>
      <td>user_name</td>
      <td>ユーザー名</td>
      <td></td>
    </tr>
    <tr>
      <td>user_image</td>
      <td>ユーザー画像URL</td>
      <td></td>
    </tr>
    <tr>
      <td>user_page</td>
      <td>ユーザーページ</td>
      <td></td>
    </tr>
    <tr>
      <td>article</td>
      <td>記事のURL</td>
      <td></td>
    </tr>
    <tr>
      <td>published_at</td>
      <td>記事作成日</td>
      <td></td>
    </tr>
    <tr>
      <td>likes_count</td>
      <td>いいね数</td>
      <td>数値が入ります</td>
    </tr>
    <tr>
      <td>is_new_arrival</td>
      <td>「NEW」のついている記事か</td>
      <td>TrueかFalseが入ります。ログインした時に表示されるユーザーのトレンドに関してはnilになります</td>
    </tr>
  </tbody>
</table>

### キャシュファイルの出力先を変更する

キャッシュファイルはデフォルトだと`ユーザーのHOMEディレクトリ/qiita_cache/`に出力されます

```
/Users/dodonki1223/qiita_cache/2019080205_normal.html
/Users/dodonki1223/qiita_cache/2019080205_personal
```
 
プログラムで下記のように追記してください

```ruby
# キャッシュの出力先ディレクトリを変更する
# ユーザーのHOMEディレクトリ配下のhogeディレクトリに出力する設定
# /Users/dodonki1223/hoge/
QiitaTrend.configure do |config|
  config.cache_directory = Dir.home + '/hoge/'
end
```

キャッシュファイルの出力先は環境変数に設定することもできます

```
QIITA_TREND_CACHE_DIR='/Users/dodonki1223/hoge/'
```

## 注意

このgemは勉強用で作成したものでソースにはアンチパターンなコメント（処理を説明するようなコメントなど）が書かれています。そこはご容赦ください
