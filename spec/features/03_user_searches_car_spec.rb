require 'rails_helper'
    #
    # There is a search form for cars on the cars index.
    # I can specify the manufacturer, color, year, and a max mileage of a car in the form.
    # The manufacturers that can be selected should be the ones shown on the manufacturer index page.
    # There should be a dropdown with the colors of all the cars. There should be no duplicate color options. If a new car with a new color is added via the form, the dropdown should update to include the color.
    # There should be a dropdown with the years of all the cars. There should be no duplicate year options and they should be ordered form most newest to oldest. If a new car with a new year is added via the form, the dropdown should update to include the year.
    # There should be a dropdown with the max mileages of the cars. The options should be 'N/A', '1000', '10,000', '100,000'. Selecting 'N/A' should not take mileage into account. Selecting a mileage should filter for cars with mileage less than or equal to the selected mileage.
    # If I submit the form without specifying anything, I should see the full car index.
    # If I submit the form with certain specifications, I should only see cars that fit those specifications.

feature 'user searches cars' do
  let!(:audi) { Manufacturer.create(name: "Audi", country: "Germany") }
  let!(:bmw) { Manufacturer.create(name: "BMW", country: "Germany") }
  let!(:toyota) { Manufacturer.create(name: "Toyota", country: "Japan") }

  let!(:car) { Car.create(manufacturer_id: audi.id, color: "Silver", year: "2000", mileage: "15000" )}
  let!(:car1) { Car.create(manufacturer_id: bmw.id, color: "Black", year: "1999", mileage: "1000" )}
  let!(:car2) { Car.create(manufacturer_id: toyota.id, color: "Silver", year: "2000", mileage: "20000" )}

  scenario 'user sees search form on the cars index' do
    visit cars_path

    expect(page).to have_button("Search")
  end

  scenario "user submits form without specifying anything" do
    visit cars_path
    click_button "Search"

    expect(page).to have_content("Silver-2000 15000")
    expect(page).to have_content("Black-1999 1000")
    expect(page).to have_content("Silver-2000 20000")
  end

  scenario 'user can search car by specifying manufacturer, color, year, and max mileage' do
    visit cars_path

    select "Audi", from: "car[manufacturer_id]"
    select "Silver", from: "car[color]"
    select "2000", from: "car[year]"
    select "100,000", from: "car[mileage]"

    click_button "Search"

    expect(page).to have_content("Results")
    expect(page).to have_content("Silver-2000 15000")
  end

  scenario 'user can search car by specifying color, and max mileage' do
    visit cars_path

    select "Black", from: "car[color]"
    select "1,000", from: "car[mileage]"

    click_button "Search"

    expect(page).to have_content("Results")
    expect(page).to have_content("Black-1999 1000")
  end

  scenario 'user sees dropdown with manufacturers shown on the manufacturer index page' do
    visit cars_path

    expect(page).to have_select("car[manufacturer_id]", options: ["", "Audi", "BMW", "Toyota"])
    expect(page).not_to have_select("car[manufacturer_id]", options: ["Mazda"])
  end

  scenario 'user sees all colors in a dropdown list' do
    visit cars_path

    expect(page).to have_select("car[color]", options: ["", "Silver", "Black"])
    expect(page).not_to have_select("car[color]", options: ["White"])
  end

  scenario 'user seels all years in a dropdown list' do
    visit cars_path

    expect(page).to have_select("car[year]", options: ["", "1999", "2000"])
    expect(page).not_to have_select("car[year]", options: ["2010"])
  end

  scenario "user sees max mileages with options 'N/A', '1000', '10,000', '100,000' and select 'N/A'" do
    visit cars_path

    expect(page).to have_select("car[mileage]", options: ["N/A","1,000", "10,000", "100,000"])

    select "N/A", from: "car[mileage]"
    click_button "Search"

    expect(page).to have_content("Silver-2000 15000")
    expect(page).to have_content("Black-1999 1000")
    expect(page).to have_content("Silver-2000 20000")
  end


end
