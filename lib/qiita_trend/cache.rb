# frozen_string_literal: true

module QiitaTrend
  class Cache
    attr_reader :file_name, :directory, :full_path

    # キャッシュファイルが格納されるデフォルトのディレクトリ
    DEFAULT_CACHE_DIRECTORY = Dir.home + '/qiita_cache/'

    # コンストラクタ
    #   クラス内で使用するインスタンス変数をセットする
    def initialize(file_name, directory = DEFAULT_CACHE_DIRECTORY)
      @file_name = file_name
      @directory = directory
      @full_path = "#{directory}#{file_name}"
    end

    # キャッシュファイルを作成する
    #   キャッシュフォルダが存在しない時は作成する
    def create_cache(content)
      Dir.mkdir(@directory) unless Dir.exist?(@directory)
      File.open(@full_path, 'wb') do |file|
        file.print(content)
      end
    end

    # キャッシュファイルを読み込む
    def load_cache
      File.open(@full_path, 'r', &:read)
    end

    # キャッシュファイルが存在するか？
    def cached?
      File.exist?(@full_path)
    end

    # キャッシュファイルをクリアする
    def clear_cache
      File.delete(@full_path) if cached?
    rescue StandardError => e
      raise e.class, 'キャッシュファイルの削除に失敗しました'
    end
  end
end
