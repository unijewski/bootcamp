class CarsController < ApplicationController
  before_action :find_car, only:[:show, :edit, :update, :destroy]
  before_action :is_owner?, only:[:show, :edit, :update, :destroy]

  def index
    @cars = current_person.cars
  end

  def show
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.owner = current_person

    if @car.save
      redirect_to @car
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to @car
    else
      render 'edit'
    end
  end

  def destroy
    @car.destroy

    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:registration_number, :model)
  end

  def find_car
    @car = Car.find(params[:id])
  end

  def is_owner?
    redirect_to cars_path unless @car.owner == current_person
  end
end
