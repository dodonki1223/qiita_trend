# frozen_string_literal: true

# Configの設定用context
RSpec.shared_context 'when set configuration' do |user_name, password, cache_directory|
  before do
    QiitaTrend.configure do |config|
      allow(config).to receive_messages(user_name:, password:, cache_directory:)
    end
  end

  after do
    QiitaTrend.configure do |config|
      allow(config).to receive_messages(user_name: nil, password: nil, cache_directory: nil)
    end
  end
end
