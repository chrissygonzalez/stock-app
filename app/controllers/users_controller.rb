class UsersController < ApplicationController
    skip_before_action :require_signin, only: [:new, :create]

    def new
        @signed_out = !signed_in?
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        @user.balance = 5000.00
        @user.save
        signin(@user)
        redirect_to user_stocks_path(@user.id)
    end

    def show
        @user = User.find(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation)
    end
end