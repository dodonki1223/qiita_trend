# frozen_string_literal: true

module QiitaTrend
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  class Configuration
    attr_accessor :user_name, :password, :cache_directory

    def initialize
      @user_name = nil
      @password = nil
      @cache_directory = nil
    end
  end
end
