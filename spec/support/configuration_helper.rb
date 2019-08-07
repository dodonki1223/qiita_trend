# frozen_string_literal: true

# Configの設定用context
RSpec.shared_context 'when set configuration' do |user_name, password, cache_directory|
  before do
    QiitaTrend.configure do |config|
      config.user_name = user_name
      config.password = password
      config.cache_directory = cache_directory
    end
  end

  # テスト後は初期値にする(afterで空にしてあげないと設定が追加された状態になってしまうため)
  after do
    QiitaTrend.configure do |config|
      config.user_name = nil
      config.password = nil
      config.cache_directory = nil
    end
  end
end
