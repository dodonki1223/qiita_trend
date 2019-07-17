# frozen_string_literal: true

require 'qiita_trend/version'
require 'nokogiri'
require 'open-uri'
require 'json'

module QiitaTrend
  # トレンドクラス
  # Qiitaのトレンド機能を提供する
  class Trend
    attr_reader :html, :trends_data

    QIITA_URI = 'https://qiita.com/'
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36'

    def initialize
      html = URI.parse(QIITA_URI)
      html = html.read('User-Agent' => USER_AGENT)
      char = html.charset
      @html = Nokogiri::HTML.parse(html, nil, char)

      trends_data = JSON.parse(@html.xpath('//div[@data-hyperapp-app="Trend"]')[0]['data-hyperapp-props'])
      @trends_data = trends_data['trend']['edges']
    end

    def items
      @trends_data.each_with_object([]) do |trend, value|
        result = {}
        result['title'] = trend['node']['title']
        result['user_name'] = trend['node']['author']['urlName']
        result['user_image'] = trend['node']['author']['profileImageUrl']
        result['likes_count'] = trend['node']['likesCount']
        result['is_new_arrival'] = trend['isNewArrival']
        result['article'] = "#{QIITA_URI}#{trend['node']['author']['urlName']}/items/#{trend['node']['uuid']}"
        value << result
      end
    end

    def new_items
      items.select do |trend|
        trend['is_new_arrival'] == true
      end
    end
  end
end
