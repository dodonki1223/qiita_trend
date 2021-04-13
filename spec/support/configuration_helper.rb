# frozen_string_literal: true

# Configの設定用context
RSpec.shared_context 'when set configuration' do |user_name, password, cache_directory|
  before do
    QiitaTrend.configure do |config|
      allow(config).to receive(:user_name).and_return(user_name)
      allow(config).to receive(:password).and_return(password)
      allow(config).to receive(:cache_directory).and_return(cache_directory)
    end
  end

  after do
    QiitaTrend.configure do |config|
      allow(config).to receive(:user_name).and_return(nil)
      allow(config).to receive(:password).and_return(nil)
      allow(config).to receive(:cache_directory).and_return(nil)
    end
  end
end
