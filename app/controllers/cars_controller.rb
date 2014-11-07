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
    @car = Car.find(params[:id])
  end

  def is_owner?
    redirect_to cars_path unless @car.owner == current_person
  end
end
