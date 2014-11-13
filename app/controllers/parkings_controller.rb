class ParkingsController < ApplicationController
  before_action :find_parking, only:[:edit, :update, :destroy]

  def index
    @parkings = Parking.search(params).paginate(:page => params[:page], :per_page => 3)
  end

  def show
    find_parking
  rescue ActiveRecord::RecordNotFound
    redirect_to parkings_path, alert: t(:not_found)
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def create
    @parking = Parking.new(parking_params)

    if @parking.save
      redirect_to @parking, notice: t(:created)
    else
      flash[:alert] = t(:error)
      render 'new'
    end
  end

  def edit
    @parking.build_address unless @parking.address
  end

  def update
    if @parking.update(parking_params)
      redirect_to @parking
      flash[:notice] = t(:updated)
    else
      flash[:alert] = t(:error)
      render 'edit'
    end
  end

  def destroy
    @parking.destroy

    redirect_to parkings_path, notice: t(:deleted)
  end

  private

  def parking_params
    params.require(:parking).permit(:places, :kind, :hour_price, :day_price, address_attributes:[:city, :street, :zip_code])
  end

  def find_parking
    @parking = Parking.find(params[:id])
  end
end
