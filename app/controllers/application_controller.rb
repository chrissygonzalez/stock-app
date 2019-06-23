class ApplicationController < ActionController::Base
    require 'pry'
    require 'iex-ruby-client'
    include SessionsHelper
end
