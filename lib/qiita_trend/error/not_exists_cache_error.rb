# frozen_string_literal: true

module QiitaTrend
  module Error
    class NotExistsCacheError < ::QiitaTrend::Error::SyntaxError
      attr_reader :cache

      def initialize(cache)
        @cache = cache
      end

      def message
        "Does not exist cache file #{@cache.full_path}"
      end
    end
  end
end
