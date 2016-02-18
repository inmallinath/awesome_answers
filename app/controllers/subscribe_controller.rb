class SubscribeController < ApplicationController
  def index
    # this renders the app/views/welcome/about.html.erb template with no layout
    #render "/welcome/about", layout:false
  end

  def create
    render json: params
  end
end
