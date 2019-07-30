# frozen_string_literal: true

module QiitaTrend
  class Target
    attr_reader :type, :url, :need_login, :cache

    def initialize(trend_type = QiitaTrend::TrendType::DAILY)
      @type = trend_type
      @url = trend_url(trend_type)
      @need_login = trend_type === QiitaTrend::TrendType::DAILY ? false : true
      @cache = cache_name(trend_type)
    end

    private

    def trend_url(type)
      case type
      when QiitaTrend::TrendType::DAILY then
        'https://qiita.com/'
      when QiitaTrend::TrendType::WEEKLY then
        'https://qiita.com/?scope=weekly'
      when QiitaTrend::TrendType::MONTHLY then
        'https://qiita.com/?scope=monthly'
      else
        nil
      end
    end

    def cache_name(type)
      if Time.now.hour >= 5 && Time.now.hour < 17
        "#{Date.today.strftime('%Y%m%d')}#{'05'}_#{type}.html"
      elsif Time.now.hour >= 17
        "#{Date.today.strftime('%Y%m%d')}#{'17'}_#{type}.html"
      elsif Time.now.hour < 5
        "#{(Date.today - 1).strftime('%Y%m%d')}#{'17'}_#{type}.html"
      end
    end
  end
end