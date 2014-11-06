class ParkingsController < ApplicationController
  def index
    @parkings = Parking.all
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def new
    @parking = Parking.new
  end

  def create
    @parking = Parking.new(parking_params)

    if @parking.save
      redirect_to @parking
    else
      render 'form'
    end
  end

  private

  def parking_params
    params.require(:parking).permit(:places, :kind, :hour_price, :day_price, :address_id, :owner_id)
  end
end
