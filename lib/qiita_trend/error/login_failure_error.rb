# frozen_string_literal: true

module QiitaTrend
  class LoginFailureError < ::QiitaTrend::SyntaxError
    def message
      "Login failed, Please confilm user_name and password(user:#{user_name},password:#{password})"
    end

    def user_name
      QiitaTrend.configuration.user_name
    end

    def password
      QiitaTrend.configuration.password
    end
  end
end
