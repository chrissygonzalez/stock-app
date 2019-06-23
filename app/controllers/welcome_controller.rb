class WelcomeController < ApplicationController
    def index
        session.clear
        @signed_out = !signed_in?
    end
end