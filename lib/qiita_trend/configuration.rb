# frozen_string_literal: true

module QiitaTrend
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  # QiitaTrendのConfigの設定する機能を提供する
  class Configuration
    # @return [String] Qiitaにログインするためのユーザー名
    attr_accessor :user_name
    # @return [String] Qiitaにログインするためのパスワード
    attr_accessor :password
    # @return [String] キャッシュファイルを保存するディレクトリ
    attr_accessor :cache_directory

    # コンストラクタ
    # Configurationクラスのインスタンスを返します
    def initialize
      puts ENV['QIITA_TREND_USER_NAME']
      puts ENV['QIITA_TREND_PASSWORD']

      @user_name = ENV['QIITA_TREND_USER_NAME'] || nil
      @password = ENV['QIITA_TREND_PASSWORD'] || nil
      @cache_directory = ENV['QIITA_TREND_CACHE_DIR'] || nil
    end
  end
end
