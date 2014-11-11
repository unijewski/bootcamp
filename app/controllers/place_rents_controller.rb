class PlaceRentsController < ApplicationController
  before_action :signed_in?

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
    @place_rent.calculate_price

    if @place_rent.save
      redirect_to @place_rent, notice: 'The place rent has been created!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
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

  def signed_in?
    if current_person.nil?
      redirect_to new_session_path, alert: 'You are not logged in!'
    end
  end
end
