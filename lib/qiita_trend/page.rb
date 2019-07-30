# frozen_string_literal: true

require 'mechanize'

module QiitaTrend
  class Page
    attr_reader :target, :html

    QIITA_LOGIN_URI = 'https://qiita.com/login'

    def initialize(ua = 'Mac Safari', trend_type = QiitaTrend::TrendType::DAILY)
      @target = QiitaTrend::Target.new(trend_type)
      @html = create_html(ua, @target)
    end

    private

    def create_html(ua, target)
      # キャッシュが存在する場合はキャッシュから取得
      cache = QiitaTrend::Cache.new(target.cache)
      return cache.load_cache if cache.cached?

      # Mechanize設定
      agent = Mechanize.new
      agent.user_agent_alias = ua

      # キャッシュが存在しない場合はキャッシュを作成しページ情報を取得する
      unless target.need_login
        page = agent.get target.url
        cache.create_cache(page.body)
        return page.body
      end

      # ログイン処理
      form = agent.get(QIITA_LOGIN_URI).forms.first
      form['identity'] = QiitaTrend.configuration.user_name
      form['password'] = QiitaTrend.configuration.password
      form.submit

      # ログイン後、対象のトレンドページを取得しキャッシュを作成
      page = agent.get target.url
      cache.create_cache(page.body)

      page.body
    end
  end
end
