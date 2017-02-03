require 'rails_helper'

    # I must specify a manufacturer name and country.
    # If I do not specify the required information, I am presented with errors.
    # If I specify the required information, the manufacturer is recorded and I am redirected to the index of manufacturers

feature 'user adds a car manufacturer',%q(
  As a car salesperson
  I want to record a car manufacturer
  So that I can keep track of the types of cars found in the lot
) do
  scenario 'user adds a new car manufacturer successfully' do
    visit new_manufacturer_path

    expect(page).to have_content "New Car Manufacturer Form"

    fill_in "Name", with: "Audi"
    fill_in "Country", with: "Germany"

    click_button "Add Manufacturer"

    expect(page).to have_content "Manufacturer added successfully"
    expect(page).to have_content "Audi"
  end

  scenario 'user does not provide proper information for a car manufacturer' do
    visit new_manufacturer_path

    click_button "Add Manufacturer"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Country can't be blank"
  end

  scenario 'user adds manufacturer successfully and is redirected to index of manufacturers' do
    visit new_manufacturer_path

    fill_in "Name", with: "Audi"
    fill_in "Country", with: "Germany"

    click_button "Add Manufacturer"

    expect(page).to have_content "Car Manufacturers"
    expect(page).to have_content "Audi"
  end
end
