# frozen_string_literal: true

module QiitaTrend
  class Target
    attr_reader :type, :url, :need_login, :cache

    def initialize(trend_type = TrendType::DAILY, date = nil)
      @type = trend_type
      @url = trend_url(trend_type)
      @need_login = trend_type != TrendType::DAILY
      @cache = cache_name(trend_type, date)
    end

    private

    def trend_url(type)
      case type
      when TrendType::DAILY then 'https://qiita.com/'
      when TrendType::WEEKLY then 'https://qiita.com/?scope=weekly'
      when TrendType::MONTHLY then 'https://qiita.com/?scope=monthly'
      end
    end

    def cache_name(type, date)
      return "#{date}_#{type}.html" unless date.nil?

      if Time.now.hour >= 5 && Time.now.hour < 17
        "#{Date.today.strftime('%Y%m%d')}05_#{type}.html"
      elsif Time.now.hour >= 17
        "#{Date.today.strftime('%Y%m%d')}17_#{type}.html"
      elsif Time.now.hour < 5
        "#{(Date.today - 1).strftime('%Y%m%d')}17_#{type}.html"
      end
    end
  end
end
