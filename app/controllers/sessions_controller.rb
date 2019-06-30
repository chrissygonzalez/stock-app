class SessionsController < ApplicationController
    skip_before_action :require_signin, only: [:new, :create]

    def new
        @user = User.new
        @users = User.all
        @signed_out = !signed_in?
    end
      
    def create
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            signin(@user)
            redirect_to user_stocks_path(@user.id)
        else
            flash[:notice] = "Either the email address or password are incorrect."
            redirect_to signin_path
        end
    end

    def destroy
        session.delete :user_id if session[:user_id]
        redirect_to signin_path
    end
end