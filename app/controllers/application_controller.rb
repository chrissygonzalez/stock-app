class ApplicationController < ActionController::Base
    require 'pry'
    require 'iex-ruby-client'
    include SessionsHelper

    before_action :require_signin
    rescue_from IEX::Errors::SymbolNotFoundError, with: :show_error

    private

    def show_error
        # binding.pry
        flash[:notice] = "Symbol Not Found"
        redirect_to user_stocks_path(current_user.id)
    end

    def require_signin
        unless signed_in?
            flash[:notice] = "You must sign in to access this section"
            redirect_to signin_path # halts request cycle
        end
    end
end
