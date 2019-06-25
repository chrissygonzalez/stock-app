class ApplicationController < ActionController::Base
    require 'pry'
    require 'iex-ruby-client'
    include SessionsHelper

    rescue_from IEX::Errors::SymbolNotFoundError, with: :show_error

    private

    def show_error
        # binding.pry
        flash[:notice] = "Symbol OMG Not Found"
        redirect_to user_stocks_path(current_user.id)
    end
end
