# frozen_string_literal: true

module QiitaTrend
  class NotExistsCacheError < ::QiitaTrend::SyntaxError
    attr_reader :cache

    def initialize(cache)
      @cache = cache
    end

    def message
      "Does not exist cache file #{@cache.full_path}"
    end
  end
end