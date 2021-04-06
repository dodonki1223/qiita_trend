# frozen_string_literal: true

module QiitaTrend
  module Error
    # キャッシュファイルが存在しない時に発生するエラークラス
    # キャッシュファイルからトレンドを取得する時、存在しないキャッシュファイルを指定した時に発生する
    class NotExistsCacheError < ::QiitaTrend::Error::SyntaxError
      # @return [Cache] Cacheクラス
      attr_reader :cache

      # コンストラクタ
      #
      # @param [Cache] cache キャッシュクラス
      def initialize(cache)
        super
        @cache = cache
      end

      # エラーメッセージを返します
      # 読み込もうとしたキャッシュファイルのフルパス含んだ形でメッセージを返します
      #
      # @return [String] エラーメッセージ
      def message
        "Does not exist cache file #{@cache.full_path}"
      end
    end
  end
end
