# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'json'
require 'uri'

module QiitaTrend
  # Qiitaのトレンドの機能を提供する
  class Trend
    # @return [Array] トレンドデータ
    attr_reader :data

    # コンストラクタ
    #
    # @param [TrendType] trend_type トレンドタイプ
    # @param [String] date 「YYYYMMDD05」,「YYYYMMDD17」形式のどちらか
    # @raise [LoginFailureError] ログインに失敗した時に発生する
    # @raise [NotExistsCacheError] 存在しないキャッシュファイルを指定した時に発生する
    def initialize(trend_type = TrendType::DAILY, date = nil)
      page = Page.new(trend_type, date)
      parsed_html = Nokogiri::HTML.parse(page.html)

      trends_data = JSON.parse(parsed_html.xpath('//div[@data-hyperapp-app="Trend"]')[0]['data-hyperapp-props'])
      @data = trends_data['trend']['edges']
    end

    # Qiitaの対象のトレンドをすべて取得
    #
    # @return [Array] Qiitaの対象のトレンドすべて
    def items
      @data.each_with_object([]) do |trend, value|
        result = {}
        result['title'] = trend['node']['title']
        result['user_name'] = trend['node']['author']['urlName']
        result['user_image'] = user_image(trend['node']['author']['profileImageUrl'])
        result['user_page'] = "#{Page::QIITA_URI}#{trend['node']['author']['urlName']}"
        result['article'] = "#{Page::QIITA_URI}#{trend['node']['author']['urlName']}/items/#{trend['node']['uuid']}"
        result['created_at'] = trend['node']['createdAt']
        result['likes_count'] = trend['node']['likesCount']
        result['is_new_arrival'] = trend['isNewArrival']
        value << result
      end
    end

    # Qiitaの対象のトレンドからNEWのものだけ取得
    #
    # @return [Array] Qiitaの対象のトレンドからNEWのものだけ
    def new_items
      items.select do |trend|
        trend['is_new_arrival'] == true
      end
    end

    private

    # ユーザーの画像のURLを取得する
    # URLデコードしimgix(画像ファイルの配信向けに特化したCDNサービス)のURLを排除する
    # クエリーパラメータも排除する
    #
    # @return [String] ユーザーの画像のURL
    def user_image(url)
      # URLデコード
      unescape_url = CGI.unescape(url)
      # imgixのURLからユーザーの画像のURLへ変換する
      exclusion_imgix = unescape_url.gsub!('https://qiita-user-profile-images.imgix.net/', '')
      # クエリパラーメーを除いた形で返す
      parse_url = URI.parse(exclusion_imgix)
      "#{parse_url.scheme}://#{parse_url.host}#{parse_url.path}"
    end
  end
end
