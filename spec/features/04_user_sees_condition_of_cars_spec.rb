require 'rails_helper'

feature 'user sees condition of the car' do
  let!(:audi) { Manufacturer.create(name: "Audi", country: "Germany") }
  let!(:bmw) { Manufacturer.create(name: "BMW", country: "Germany") }
  let!(:toyota) { Manufacturer.create(name: "Toyota", country: "Japan") }

  scenario 'user sees car listed in Poor condition on the index page' do
    visit new_car_path

    select "Audi", from: "Manufacturer"
    fill_in "Color", with: "Silver"
    fill_in "Year", with: "2011"
    fill_in "Mileage", with: "60000"

    click_button "Add Car"

    expect(page).to have_content("Poor")
  end

  scenario 'user sees cars listed in Fair condition on the index page' do
    visit new_car_path

    select "Audi", from: "Manufacturer"
    fill_in "Color", with: "Silver"
    fill_in "Year", with: "2012"
    fill_in "Mileage", with: "10000"

    click_button "Add Car"

    expect(page).to have_content("Fair")
  end

  scenario 'user sees cars listed in Good condition on the index page' do
    visit new_car_path

    select "Audi", from: "Manufacturer"
    fill_in "Color", with: "Silver"
    fill_in "Year", with: "2015"
    fill_in "Mileage", with: "900"

    click_button "Add Car"

    expect(page).to have_content("Good")
  end

  scenario 'user sees cars listed in Excellent condition on the index page' do
    visit new_car_path

    select "Audi", from: "Manufacturer"
    fill_in "Color", with: "Silver"
    fill_in "Year", with: "2016"
    fill_in "Mileage", with: "500"

    click_button "Add Car"

    expect(page).to have_content("Excellent")
  end
end
