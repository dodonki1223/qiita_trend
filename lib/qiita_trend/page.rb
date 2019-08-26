# frozen_string_literal: true

require 'mechanize'

module QiitaTrend
  # Qiitaのページをスクレイピングしページ情報を取得する機能を提供する
  class Page
    # @return [TrendType] トレンドタイプ（TrendType::DAILY,TrendType::WEEKLY,TrendType::MONTHLY）
    attr_reader :target
    # @return [String] Qiitaページのスクレイピング結果
    attr_reader :html
    # @return [Cache] Cacheクラス
    attr_reader :cache

    # QiitaのTOPページURL
    QIITA_URI = 'https://qiita.com/'
    # QiitaのログインページURL
    QIITA_LOGIN_URI = 'https://qiita.com/login'

    # コンストラクタ
    #
    # @param [TrendType] trend_type トレンドタイプ
    # @param [String] date 「YYYYMMDD05」,「YYYYMMDD17」形式のどちらか
    # @raise [LoginFailureError] ログインに失敗した時に発生する
    # @raise [NotExistsCacheError] 存在しないキャッシュファイルを指定した時に発生する
    def initialize(trend_type = TrendType::DAILY, date = nil)
      @target = Target.new(trend_type, date)
      save_cache_directory = QiitaTrend.configuration.cache_directory.nil? ? Cache::DEFAULT_CACHE_DIRECTORY : QiitaTrend.configuration.cache_directory
      @cache = Cache.new(target.cache, save_cache_directory)

      # 指定されたキャッシュファイルが存在しない場合は処理を終了
      unless date.nil?
        raise Error::NotExistsCacheError, @cache unless @cache.cached?
      end

      # キャッシュが存在する場合はキャッシュから取得
      @html = @cache.cached? ? @cache.load_cache : create_html(@target)

      # キャッシュが存在しない時はキャッシュを作成する
      @cache.create_cache(@html) unless @cache.cached?
    end

    private

    # Qiitaのページをスクレイピングした結果を取得します
    #
    # @param [Target] target Targetクラス
    # @raise [LoginFailureError] ログインに失敗した時に発生する
    # @return [String] Qiitaをスクレイピングした結果
    def create_html(target)
      agent = Mechanize.new
      agent.user_agent_alias = 'Mac Safari'
      login_qiita(agent) if target.need_login
      agent.get(target.url).body
    end

    # Qiitaへログインする
    #
    # @param [Mechanize] agent Mechanizeクラス
    # @raise [LoginFailureError] ログインに失敗した時に発生する
    def login_qiita(agent)
      form = agent.get(QIITA_LOGIN_URI).forms.first
      form['identity'] = QiitaTrend.configuration.user_name
      form['password'] = QiitaTrend.configuration.password
      logged_page = form.submit

      # ページのタイトルにLoginが含まれていたらログイン失敗とする
      raise Error::LoginFailureError if logged_page.title.include?('Login')
    end
  end
end
