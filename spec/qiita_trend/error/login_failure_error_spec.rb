# frozen_string_literal: true

RSpec.describe QiitaTrend::Error::LoginFailureError do
  before do
    QiitaTrend.configure do |config|
      config.user_name = 'hogehoge'
      config.password = 'test1234'
    end
  end

  # テスト後は初期値にする
  after do
    QiitaTrend.configure do |config|
      config.user_name = nil
      config.password = nil
    end
  end

  let(:login_failure) { described_class.new }

  describe '#message' do
    it 'メッセージにuser_nameが含まれていること' do
      expect(login_failure.message).to include(QiitaTrend.configuration.user_name)
    end

    it 'メッセージにpasswordが含まれていること' do
      expect(login_failure.message).to include(QiitaTrend.configuration.password)
    end
  end

  describe '#user_name' do
    it '設定されたuser_nameであること' do
      expect(login_failure.user_name).to eq QiitaTrend.configuration.user_name
    end
  end

  describe '#password' do
    it '設定されたpasswordであること' do
      expect(login_failure.password).to eq QiitaTrend.configuration.password
    end
  end
end
