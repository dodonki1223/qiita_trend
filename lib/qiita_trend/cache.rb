# frozen_string_literal: true

module QiitaTrend
  # Qiitaのトレンドをキャッシュする機能を提供する
  class Cache
    # @return [String] ファイル名
    attr_reader :file_name
    # @return [String] キャッシュファイルを格納するディレクトリ（デフォルト値はDEFAULT_CACHE_DIRECTORYになります）
    attr_reader :directory
    # @return [String] キャッシュファイルへのフルパス
    attr_reader :full_path

    # キャッシュファイルが格納されるデフォルトのディレクトリ
    DEFAULT_CACHE_DIRECTORY = "#{Dir.home}/qiita_cache/"

    # コンストラクタ
    # Cacheクラスのインスタンスを返します
    #
    # @param [String] file_name ファイル名
    # @param [String] directory キャッシュが格納する・されているディレクトリ
    def initialize(file_name, directory = DEFAULT_CACHE_DIRECTORY)
      @file_name = file_name
      @directory = directory
      @full_path = "#{directory}#{file_name}"
    end

    # キャッシュファイルを作成する
    # ※キャッシュフォルダが存在しない場合は作成します
    #
    # @param [String] content 書き込む内容
    def create_cache(content)
      Dir.mkdir(@directory) unless Dir.exist?(@directory)
      File.open(@full_path, 'wb') do |file|
        file.print(content)
      end
    end

    # キャッシュファイルを読み込む
    # File.openを使用しファイルを読み込みます
    #
    # @return [Object]
    def load_cache
      File.open(@full_path, 'r', &:read)
    end

    # キャッシュファイルが存在するかどうかを判定します
    #
    # @return [Boolean]
    def cached?
      File.exist?(@full_path)
    end
  end
end
