class ApplicationController < ActionController::Base
    # require 'pry'
    require 'iex-ruby-client'
    include SessionsHelper

    before_action :require_signin
    rescue_from IEX::Errors::SymbolNotFoundError, with: :no_symbol_error
    rescue_from Faraday::ConnectionFailed, with: :no_connection_error

    private

    def no_symbol_error
        flash[:notice] = "Please enter a valid stock ticker symbol."
        redirect_to user_stocks_path(current_user.id)
    end

    def no_connection_error
        flash[:notice] = "Unable to connect. Please check your internet connection and try again."
        redirect_to user_stocks_path(current_user.id)
    end

    def require_signin
        unless signed_in?
            # flash[:notice] = "You must sign in to access this section."
            redirect_to new_user_path
        end
    end
end
