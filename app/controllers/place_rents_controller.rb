class PlaceRentsController < ApplicationController
  def index
    @place_rents = PlaceRent.all
  end

  def show
    @place_rent = PlaceRent.find(params[:id])
  end

  def new
    @place_rent = PlaceRent.new(parking: find_parking)
  end

  def create
    @place_rent = PlaceRent.new(place_rent_params)
    @place_rent.parking = find_parking

    if @place_rent.save
      redirect_to @place_rent
    else
      render 'new'
    end
  end

  private

  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date, :car_id)
  end

  def find_parking
    @parking = Parking.find(params[:parking_id])
  end
end
