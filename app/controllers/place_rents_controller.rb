class PlaceRentsController < ApplicationController
  before_action :require_logged_person

  def index
    @place_rents = PlaceRent.all
  end

  def show
    @place_rent = PlaceRent.find_by(identifier: params[:id])
  end

  def new
    @place_rent = PlaceRent.new(parking: find_parking)
  end

  def create
    @place_rent = PlaceRent.new(place_rent_params)
    @place_rent.parking = find_parking
    @place_rent.identifier = identifier
    @place_rent.calculate_price

    if @place_rent.save
      redirect_to @place_rent, notice: 'The place rent has been created!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'new'
    end
  end

  private

  def identifier
    SecureRandom.uuid
  end

  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date, :car_id)
  end

  def find_parking
    @parking = Parking.find(params[:parking_id])
  end
end
