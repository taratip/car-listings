require 'pry'
class CarsController < ApplicationController
  def index
    @cars = Car.all
    @manufacturer_collection = Manufacturer.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
    @manufacturer_collection = Manufacturer.all
  end

  def create
    @car = Car.new(car_params)
    @car.condition = get_condition(car_params[:year].to_i, car_params[:mileage].to_i)

    if @car.save
      redirect_to cars_path, notice: "Car added successfully"
    else
      @manufacturer_collection = Manufacturer.all
      render :new
    end
  end

  def search
    criteria = ''
    query = ''

    if (car_params[:manufacturer_id].empty? and
      car_params[:color].empty? and
      car_params[:year].empty? and
      car_params[:mileage] == "0")

      @cars = Car.all
    else
      if (!car_params[:manufacturer_id].empty?)
        criteria += "manufacturer_id = #{car_params[:manufacturer_id]} "
      end

      if (!car_params[:color].empty?)
        if (!car_params[:manufacturer_id].empty?)
          criteria += "and "
        end
        criteria += "color = '#{car_params[:color]}' "
      end

      if (!car_params[:year].empty?)
        if (!car_params[:manufacturer_id].empty? or !car_params[:color].empty?)
          criteria += "and "
        end
        criteria += "year = #{car_params[:year]} "
      end

      if (car_params[:mileage] != "0")
        if (!car_params[:manufacturer_id].empty? or !car_params[:color].empty? or !car_params[:year].empty?)
          criteria += "and "
        end
        criteria += "mileage <= #{car_params[:mileage]}"
      end

      @cars = Car.where(criteria)
    end
  end

  private

  def car_params
    params.require(:car).permit(
      :manufacturer_id,
      :color,
      :year,
      :mileage,
      :description
    )
  end

  def get_condition(year, mileage)
    car_condition = ''
    if ((year < 2011) or (year == 2011 and mileage > 900))
      car_condition = 'Poor'
    elsif ((year == 2011 and mileage <= 900) or
      (year > 2011 and year < 2015) or
      (year == 2015 and mileage > 900))
      car_condition = "Fair"
    elsif ((year == 2015 and mileage <= 900) or
      (year == 2016 and mileage > 900))
      car_condition = "Good"
    elsif ((year == 2016 and mileage <= 900) or
      (year > 2016))
      car_condition = "Excellent"
    end
    car_condition
  end
end
