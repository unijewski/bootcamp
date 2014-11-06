class ParkingsController < ApplicationController
  before_action :find_parking, only:[:show, :edit, :update, :destroy]

  def index
    @parkings = Parking.all
  end

  def show
  end

  def new
    @parking = Parking.new
  end

  def create
    @parking = Parking.new(parking_params)

    if @parking.save
      redirect_to @parking
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @parking.update(parking_params)
      redirect_to @parking
      flash[:notice] = 'The parking has been updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @parking.destroy

    redirect_to parkings_path
  end

  private

  def parking_params
    params.require(:parking).permit(:places, :kind, :hour_price, :day_price, address_attributes:[:city, :street, :zip_code])
  end

  def find_parking
    @parking = Parking.find(params[:id])
  end
end
