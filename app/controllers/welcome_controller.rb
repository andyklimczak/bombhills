class WelcomeController < ApplicationController
  def index
    @locations = Location.all
    gon.locations = @locations
    gon.user_signed_in = user_signed_in?
  end
end
