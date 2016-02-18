class WelcomeController < ApplicationController

  # We call instance methods defined in a controller `actions`. We need actions in order to handle user requests.

  def index

  end

  def about
    cookies.signed[:abc] = "xyz"
    cookies.signed[:hello] = "Test this cookie value"
    #cookies.permanent.signed[:hello1] = "Test this cookie value"
    session[:foo] = "bar"
    session[:foo1] = "bar1"
    session[:foo2] = "bar2"
  end

  def greet
    @name = params[:name]
    Rails.logger.info '<<<<<<<>>>>>>>>>'
    Rails.logger.info cookies.signed[:abc]
    Rails.logger.info cookies.signed[:hello]
    Rails.logger.info '<<<<<<<>>>>>>>>>'


  end
end
