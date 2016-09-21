module Concerns
  module Login
    extend ActiveSupport::Concern

    def login_user(user)
      @current_user = user
      session[:user_id] = user.id
    end

    def current_user
      @current_user ||= user_from_session
    end

    private

    def user_from_session
      id = session[:user_id]
      return set_default_user unless id
      UserService.new.find(id)
    end

    def set_default_user
      puts "Getting default user"
      UserService.new.default_user.tap do |user|
        session[:user_id] = user.id
      end
    end

  end
end

