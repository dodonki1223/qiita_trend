# frozen_string_literal: true

module QiitaTrend
  class Cache
    attr_reader :file_name, :directory, :full_path

    # キャッシュファイルが格納されるデフォルトのディレクトリ
    DEFAULT_CACHE_DIRECTORY = File.expand_path('../..', __dir__) + '/cache/'

    # コンストラクタ
    #   クラス内で使用するインスタンス変数をセットする
    def initialize(file_name, directory = DEFAULT_CACHE_DIRECTORY)
      @file_name = file_name
      @directory = directory
      @full_path = "#{directory}#{file_name}"
    end

    # キャッシュファイルを作成する
    #   キャッシュフォルダが存在しない時は作成する
    #   シリアライズしたものをキャッシュファイルとして保存する
    def create_cache(content)
      Dir.mkdir(@directory) unless Dir.exist?(@directory)
      File.open(@full_path, 'wb') do |file|
        serialize_file = Marshal.dump(content)
        # 改行なしで書き込む
        # ※putsを使用した場合、末尾に改行がつく
        file.print(serialize_file)
      end
    end

    # キャッシュファイルを読み込む
    #   シリアライズされたキャッシュファイルをデシリアライズして読み込む
    def load_cache
      deserialize_file = ''
      File.open(@full_path, 'r') { |file| deserialize_file = file.read }
      Marshal.load(deserialize_file)
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
