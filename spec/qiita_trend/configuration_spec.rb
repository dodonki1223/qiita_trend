# frozen_string_literal: true

RSpec.describe QiitaTrend::Configuration do
  before do
    QiitaTrend.configure do |config|
      config.user_name = 'hogehoge'
      config.password = 'test1234'
      config.cache_directory = Dir.home + '/hoge/'
    end
  end

  # afterで空にしてあげないと設定が追加された状態になってしまうため
  # テスト後は初期値にする
  after do
    QiitaTrend.configure do |config|
      config.user_name = nil
      config.password = nil
      config.cache_directory = nil
    end
  end

  let(:config) { QiitaTrend.configuration }

  it 'ユーザー名がセットされていること' do
    expect(config.user_name).to eq 'hogehoge'
  end

  it 'パスワードがセットされていること' do
    expect(config.password).to eq 'test1234'
  end

  it 'キャッシュファイルの保存先がセットされていること' do
    expect(config.cache_directory).to eq Dir.home + '/hoge/'
  end
end
