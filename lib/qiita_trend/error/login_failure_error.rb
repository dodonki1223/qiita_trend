# frozen_string_literal: true

module QiitaTrend
  module Error
    # Qiitaへログイン失敗時に発生するエラークラス
    class LoginFailureError < ::QiitaTrend::Error::SyntaxError
      # エラーメッセージを返します
      # ログインに失敗した時のユーザー名とパスワードを含んだ形でメッセージを返します
      #
      # @return [String] エラーメッセージ
      def message
        "Login failed, Please confilm user_name and password(user:#{user_name},password:#{password})"
      end

      # ログインに失敗した時のユーザー名を返します
      #
      # @return [String] ユーザー名(Configの設定したユーザー名)
      def user_name
        QiitaTrend.configuration.user_name
      end

      # ログインに失敗した時のパスワードを返します
      #
      # @return [String] パスワード(Configの設定したパスワード)
      def password
        QiitaTrend.configuration.password
      end
    end
  end
end
