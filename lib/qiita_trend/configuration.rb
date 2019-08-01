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
    attr_accessor :user_name, :password

    def initialize
      @user_name = 'set user name'
      @password = 'set password'
    end
  end
end
