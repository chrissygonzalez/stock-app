class SessionsController < ApplicationController
    def new
        # nothing to do here!
    end
 
    def create
        @user = User.find_by(name: params[:user_name])
        if @user && @user.authenticate(params[:password])
            signin(@user)
            redirect_to user_path(@user.id)
        else
            redirect_to new_user_path
        end
    end
end