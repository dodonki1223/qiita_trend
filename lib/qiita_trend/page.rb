# frozen_string_literal: true

require 'mechanize'

module QiitaTrend
  class Page
    attr_reader :target, :html

    QIITA_URI = 'https://qiita.com/'
    QIITA_LOGIN_URI = 'https://qiita.com/login'

    def initialize(trend_type = TrendType::DAILY, date = nil)
      @target = Target.new(trend_type, date)
      cache = Cache.new(target.cache)

      # 指定されたキャッシュファイルが存在しない場合は処理を終了
      unless date.nil?
        raise StandardError, '指定されたキャッシュファイルが存在しません' unless cache.cached?
      end

      # キャッシュが存在する場合はキャッシュから取得
      @html = cache.cached? ? cache.load_cache : create_html(@target)

      # キャッシュが存在しない時はキャッシュを作成する
      cache.create_cache(@html) unless cache.cached?
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
        raise StandardError, 'ログインに失敗しました（ユーザー名とパスワードでログインできることを確認してください）' if logged_page.title.include?('Login')
      end

      agent.get(target.url).body
    end
  end
end
