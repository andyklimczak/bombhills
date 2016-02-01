require 'rails_helper'

RSpec.describe "spots/index", type: :view do
  before(:each) do
    assign(:spots, [
      Spot.create!(
        :latitude => "9.99",
        :longitude => "9.99",
        :description => "Description",
        :title => "Title",
        :difficulty => "Difficulty",
        :user => nil,
        :post => nil
      ),
      Spot.create!(
        :latitude => "9.99",
        :longitude => "9.99",
        :description => "Description",
        :title => "Title",
        :difficulty => "Difficulty",
        :user => nil,
        :post => nil
      )
    ])
  end

  it "renders a list of spots" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Difficulty".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
