# frozen_string_literal: true

require 'mechanize'

module QiitaTrend
  class Page
    attr_reader :page, :html

    QIITA_URI = 'https://qiita.com/'

    def initialize(ua)
      agent = Mechanize.new
      agent.user_agent_alias = ua

      @page = agent.get QIITA_URI
      @html = @page.body
    end
  end
end
