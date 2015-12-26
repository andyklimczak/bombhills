class MapController < ApplicationController
  def index
    @locations = Location.all
    gon.jbuilder
    gon.user_signed_in = user_signed_in?
  end
end
