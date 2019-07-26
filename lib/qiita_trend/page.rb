# frozen_string_literal: true

require 'mechanize'

module QiitaTrend
  class Page
    attr_reader :html

    QIITA_URI = 'https://qiita.com/'

    def initialize(ua)
      @html = create_html(ua)
    end

    private

    def create_html(ua)
      # キャッシュが存在する場合はキャッシュから取得
      cache = QiitaTrend::Cache.new('trend_cache.html')
      return cache.load_cache if cache.cached?

      # キャッシュが存在しない場合はキャッシュを作成しページ情報を取得する
      agent = Mechanize.new
      agent.user_agent_alias = ua
      page = agent.get QIITA_URI
      cache.create_cache(page.body)

      page.body
    end
  end
end
