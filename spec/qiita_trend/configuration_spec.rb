# frozen_string_literal: true

RSpec.describe QiitaTrend::Configuration do
  include_context 'when set configuration', 'hoge', 'hoge1234', "#{Dir.home}/hoge/"

  let(:config) { QiitaTrend.configuration }

  it 'ユーザー名がセットされていること' do
    expect(config.user_name).to eq 'hoge'
  end

  it 'パスワードがセットされていること' do
    expect(config.password).to eq 'hoge1234'
  end

  it 'キャッシュファイルの保存先がセットされていること' do
    expect(config.cache_directory).to eq "#{Dir.home}/hoge/"
  end
end
