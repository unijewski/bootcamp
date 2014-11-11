class CarsController < ApplicationController
  before_action :signed_in?
  before_action :find_car, only: [:edit, :update, :destroy]

  def index
    @cars = current_person.cars
  end

  def show
    find_car
  rescue ActiveRecord::RecordNotFound
    redirect_to cars_path, alert: 'Car not found!'
  end

  def new
    @car = Car.new
  end

  def create
    @car = current_person.cars.build(car_params)

    if @car.save
      redirect_to @car, notice: 'The car has been created!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to @car, notice: 'The car has been updated!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @car.destroy

    redirect_to cars_path, notice: 'The car has been deleted!'
  end

  private

  def car_params
    params.require(:car).permit(:registration_number, :model)
  end

  def find_car
    @car = current_person.cars.find(params[:id])
  end

  def signed_in?
    if current_person.nil?
      redirect_to new_session_path, alert: 'You are not logged in!'
    end
  end
end
