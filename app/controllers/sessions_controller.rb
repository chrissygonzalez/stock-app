class SessionsController < ApplicationController
    def new
        # nothing to do here!
    end
 
    def create
        session[:username] = params[:username]
        redirect_to '/'
    end
end