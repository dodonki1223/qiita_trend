# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'json'

module QiitaTrend
  class Trend
    attr_reader :data

    def initialize(ua = 'Mac Safari')
      page = QiitaTrend::Page.new(ua)
      parsed_html = Nokogiri::HTML.parse(page.html)

      trends_data = JSON.parse(parsed_html.xpath('//div[@data-hyperapp-app="Trend"]')[0]['data-hyperapp-props'])
      @data = trends_data['trend']['edges']
    end

    def items
      @data.each_with_object([]) do |trend, value|
        result = {}
        result['title'] = trend['node']['title']
        result['user_name'] = trend['node']['author']['urlName']
        result['user_image'] = trend['node']['author']['profileImageUrl']
        result['likes_count'] = trend['node']['likesCount']
        result['is_new_arrival'] = trend['isNewArrival']
        result['article'] = "#{Page::QIITA_URI}#{trend['node']['author']['urlName']}/items/#{trend['node']['uuid']}"
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
