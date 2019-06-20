class StocksController < ApplicationController
    def index
        @user = current_user
        @stocks = User.find(current_user.id).stocks ||= nil
    end
end