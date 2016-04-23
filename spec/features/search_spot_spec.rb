require 'rails_helper'

RSpec.describe "searching for a spot", :type => :feature do

  it "can search from welcome page" do
    visit root_path
    within("#form") do
      fill_in 'search', :with => 'Amherst'
    end
    click_button 'Search'
    expect(page).to have_current_path(spots_path(search: 'Amherst'))
  end

  #it "can search from map page" do
    #visit spots_path
    #within("#form") do
      #fill_in 'search-input', :with => 'Amherst'
    #end
    #click_button 'map-search-button'
    #expect(page).to have_current_path(spots_path(search: 'Amherst'))
  #end
end
