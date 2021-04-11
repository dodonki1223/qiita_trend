# frozen_string_literal: true

module QiitaTrend
  # Qiitaの対象のトレンドの機能を提供する
  class Target
    # @return [TrendType] トレンドタイプ（TrendType::DAILY,TrendType::WEEKLY,TrendType::MONTHLY）
    attr_reader :type
    # @return [String] トレンドを取得するQiitaのページURL
    attr_reader :url
    # @return [Boolean] Qiitaへのログインが必要かどうか
    attr_reader :need_login
    # @return [String] キャッシュファイル名
    attr_reader :cache

    # コンストラクタ
    #
    # @param [TrendType] trend_type トレンドタイプ
    # @param [String] date 「YYYYMMDD05」,「YYYYMMDD17」形式のどちらか
    def initialize(trend_type = TrendType::NORMAL, date = nil)
      @type = trend_type
      @url = trend_url
      @need_login = need_login?(trend_type)
      @cache = cache_name(trend_type, date)
    end

    private

    # トレンドのURLを取得する
    #
    # @return [String] トレンドを取得するQiitaのページURL
    def trend_url
      Page::QIITA_URI
    end

    # Qiitaにログインが必要か
    #
    # @param [TrendType] trend_type トレンドタイプ
    # @return [Boolean] True：Qiitaへログインが必要、False：Qiitaへログイン不要
    def need_login?(trend_type)
      trend_type != TrendType::NORMAL
    end

    # キャッシュ名を取得する
    # キャシュ名はYYYYMMDD05_daily.html,YYYYMMDD17_weekly.htmlなどの形式になります
    # dateが指定されていなかったら現在時刻からキャッシュファイル名を作成し指定されていたらそのdateからキャッシュ名を取得する
    #
    # @param [TrendType] type トレンドタイプ
    # @param [String] date 「YYYYMMDD05」,「YYYYMMDD17」形式のどちらか
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
