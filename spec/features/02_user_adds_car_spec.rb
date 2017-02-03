require 'rails_helper'

    # I must specify the manufacturer, color, year, and mileage of the car (an association between the car and an existing manufacturer should be created).
    # Only years from 1920 and above can be specified.
    # I can optionally specify a description of the car.
    # If I enter all of the required information in the required formats, the car is recorded and I am presented with a notification of success.
    # If I do not specify all of the required information in the required formats, the car is not recorded and I am presented with errors.
    # Upon successfully creating a car, I am redirected back to the index of cars.

feature 'user adds a newly acquired car', %q(
  As a car salesperson
  I want to record a newly acquired car
  So that I can list it in my lot
) do

  let!(:audi) { Manufacturer.create(name: "Audi", country: "Germany") }
  let!(:bmw) { Manufacturer.create(name: "BMW", country: "Germany") }
  let!(:toyota) { Manufacturer.create(name: "Toyota", country: "Japan") }

  scenario 'user adds a newly acquired car successfully' do
    visit new_car_path

    expect(page).to have_content("New Car Form")

    select "Audi", from: "Manufacturer"
    fill_in "Color", with: "Silver"
    fill_in "Year", with: "1998"
    fill_in "Mileage", with: "10000"
    fill_in "Description", with: "In good shape, well maintained"

    click_button "Add Car"

    expect(page).to have_content("Car added successfully")
  end

  scenario 'user cannot add a car with year below 1920' do
    visit new_car_path

    select "Toyota", from: "Manufacturer"
    fill_in "Color", with: "Silver"
    fill_in "Year", with: "1919"
    fill_in "Mileage", with: "10000"

    click_button "Add Car"

    expect(page).to have_content("Year must be greater than or equal to 1920")
  end

  scenario 'user adds a car successfully without specifying a description' do
    visit new_car_path

    select "Audi", from: "Manufacturer"
    fill_in "Color", with: "Silver"
    fill_in "Year", with: "1998"
    fill_in "Mileage", with: "10000"

    click_button "Add Car"

    expect(page).to have_content("Car added successfully")
  end

  scenario 'user adds a car with invalid information and is presented with errors' do
    visit new_car_path

    click_button "Add Car"

    expect(page).to have_content("Color can't be blank")
    expect(page).to have_content("Year can't be blank")
    expect(page).to have_content("Mileage can't be blank")
  end

  scenario 'user add a car successfully and is redirected to the index of cars' do
    visit new_car_path

    select "BMW", from: "Manufacturer"
    fill_in "Color", with: "Silver"
    fill_in "Year", with: "1919"
    fill_in "Mileage", with: "10000"

    click_button "Add Car"

    expect(page).to have_content("Car Listings")
  end
end
