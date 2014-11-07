class ParkingsController < ApplicationController
  before_action :find_parking, only:[:show, :edit, :update, :destroy]

  def index
    @parkings = Parking.all
  end

  def show
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def create
    @parking = Parking.new(parking_params)

    if @parking.save
      redirect_to @parking, notice: 'The parking has been created!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'new'
    end
  end

  def edit
    @parking.build_address
  end

  def update
    if @parking.update(parking_params)
      redirect_to @parking
      flash[:notice] = 'The parking has been updated!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @parking.destroy

    redirect_to parkings_path, notice: 'The parking has been deleted!'
  end

  private

  def parking_params
    params.require(:parking).permit(:places, :kind, :hour_price, :day_price, address_attributes:[:city, :street, :zip_code])
  end

  def find_parking
    @parking = Parking.find(params[:id])
  end
end
