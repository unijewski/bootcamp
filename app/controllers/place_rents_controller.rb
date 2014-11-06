class PlaceRentsController < ApplicationController
  def index
    @place_rents = PlaceRent.all
  end
end
