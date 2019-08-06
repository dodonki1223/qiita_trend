# frozen_string_literal: true

require 'bundler/setup'
require 'support/cache_helper'
require 'webmock/rspec'
require 'vcr'
require 'simplecov'

# SimpleCovのロード処理
SimpleCov.start

require 'qiita_trend'

# Webmock用のデータの作成用設定
# ※vcrを使用し、簡単に作成する
VCR.configure do |c|
  # vcrで作成されるファイルの保存先
  c.cassette_library_dir = 'spec/vcr'
  # hook対象のライブラリ
  c.hook_into :webmock
  # vcrブロック外のHTTP通信は許可する
  # ※これをtrueにしないとvcr外でHTTP通信を行なうと「UnhandledHTTPRequestError」が発生してしまう
  c.allow_http_connections_when_no_cassette = true
  # vcrで作成するymlファイルの作成方法設定
  # Once,New_episodes,None,Allがある
  # https://relishapp.com/vcr/vcr/v/3-0-3/docs/record-modes/new-episodes
  c.default_cassette_options = { record: :new_episodes }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
