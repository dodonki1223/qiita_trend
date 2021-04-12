# frozen_string_literal: true

RSpec.describe QiitaTrend::Configuration do
  let(:config) { QiitaTrend.configuration }

  context 'when setting environment' do
    before do
      allow(ENV).to receive(:[]).with('QIITA_TREND_USER_NAME').and_return('environment_hoge')
      allow(ENV).to receive(:[]).with('QIITA_TREND_PASSWORD').and_return('environment_hoge1234')
      allow(ENV).to receive(:[]).with('QIITA_TREND_CACHE_DIR').and_return("#{Dir.home}/environment_hoge/")
    end

    it 'ユーザー名がセットされていること' do
      expect(config.user_name).to eq 'environment_hoge'
    end

    it 'パスワードがセットされていること' do
      expect(config.password).to eq 'environment_hoge1234'
    end

    it 'キャッシュファイルの保存先がセットされていること' do
      expect(config.cache_directory).to eq "#{Dir.home}/environment_hoge/"
    end
  end

  context 'when not setting environment' do
    include_context 'when set configuration', 'hogehoge', 'hoge1234', "#{Dir.home}/hoge/"

    it 'ユーザー名がセットされていること' do
      expect(config.user_name).to eq 'hogehoge'
    end

    it 'パスワードがセットされていること' do
      expect(config.password).to eq 'hoge1234'
    end

    it 'キャッシュファイルの保存先がセットされていること' do
      expect(config.cache_directory).to eq "#{Dir.home}/hoge/"
    end
  end
end
