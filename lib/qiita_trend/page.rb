# frozen_string_literal: true

require 'mechanize'

module QiitaTrend
  class Page
    attr_reader :target, :html, :cache

    QIITA_URI = 'https://qiita.com/'
    QIITA_LOGIN_URI = 'https://qiita.com/login'

    def initialize(trend_type = TrendType::DAILY, date = nil)
      @target = Target.new(trend_type, date)
      save_cache_directory = QiitaTrend.configuration.cache_directory.nil? ? Cache::DEFAULT_CACHE_DIRECTORY : QiitaTrend.configuration.cache_directory
      @cache = Cache.new(target.cache, save_cache_directory)

      # 指定されたキャッシュファイルが存在しない場合は処理を終了
      unless date.nil?
        raise StandardError, '指定されたキャッシュファイルが存在しません' unless @cache.cached?
      end

      # キャッシュが存在する場合はキャッシュから取得
      @html = @cache.cached? ? @cache.load_cache : create_html(@target)

      # キャッシュが存在しない時はキャッシュを作成する
      @cache.create_cache(@html) unless @cache.cached?
    end

    private

    def create_html(target)
      agent = Mechanize.new
      agent.user_agent_alias = 'Mac Safari'

      # ログイン処理
      if target.need_login
        form = agent.get(QIITA_LOGIN_URI).forms.first
        form['identity'] = QiitaTrend.configuration.user_name
        form['password'] = QiitaTrend.configuration.password
        logged_page = form.submit

        # ページのタイトルにLoginが含まれていたらログイン失敗とする
        raise QiitaTrend::LoginFailureError if logged_page.title.include?('Login')
      end

      agent.get(target.url).body
    end
  end
end
