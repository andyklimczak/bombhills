require 'rails_helper'

RSpec.describe "spots/show", type: :view do
  before(:each) do
    @spot = assign(:spot, Spot.create!(
      :latitude => "9.99",
      :longitude => "9.99",
      :description => "Description",
      :title => "Title",
      :difficulty => "Difficulty",
      :user => nil,
      :post => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Difficulty/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
