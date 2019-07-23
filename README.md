# QiitaTrend


[![Gem Version](https://badge.fury.io/rb/qiita_trend.svg)](https://badge.fury.io/rb/qiita_trend) [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/dodonki1223/qiita_trend/blob/master/LICENSE.txt) [![CircleCI](https://circleci.com/gh/dodonki1223/qiita_trend/tree/master.svg?style=svg)](https://circleci.com/gh/dodonki1223/qiita_trend/tree/master)

QiitaのDailyのトレンドを取得することができます（**Weekly、Monthlyは対応していません**）

## 概要

[Qiita](https://qiita.com/)のTOPページをスクレイピングしDailyのトレンドを取得します

## インストール

Add this line to your application's Gemfile:

```ruby
gem 'qiita_trend'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qiita_trend

## 使用方法

サクッと使ってみたい方は`gem install qiita_trend`を実行後、下記コマンドをターミナルで実行してください  
**2019年7月24日 08時00分頃実行した結果です**

```shell
$ ruby -r qiita_trend -e "pp QiitaTrend::Trend.new.items"

[{"title"=>"2019年版 最先端のフロントエンド開発者になるために学ぶべきこと",
  "user_name"=>"baby-degu",
  "user_image"=>
   "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/407975/profile-images/1557035044",
  "likes_count"=>546,
  "is_new_arrival"=>false,
  "article"=>"https://qiita.com/baby-degu/items/da30fa71b8f48fffc568"},
 {"title"=>"【俺は絶対楽してやるんだ】徹底的に学習モチベーションを維持する方法",
  "user_name"=>"rexiaxm7",
  "user_image"=>"https://avatars0.githubusercontent.com/u/39663347?v=4",
  "likes_count"=>477,
  "is_new_arrival"=>false,
  "article"=>"https://qiita.com/rexiaxm7/items/b745185f319edd1a17ab"},
  ...
```

自分のプロジェクトで使用したい場合は下記のように記述することで使用することができます

```ruby
qiita_trend = QiitaTrend::Trend.new

# Dailyのトレンドを全て取得する
p qiita_trend.items
# DailyのトレンドでNEWのものだけを取得する
p qiita_trend.new_items
```
