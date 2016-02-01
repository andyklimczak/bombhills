require 'rails_helper'

RSpec.describe "spots/edit", type: :view do
  before(:each) do
    @spot = assign(:spot, Spot.create!(
      :latitude => "9.99",
      :longitude => "9.99",
      :description => "MyString",
      :title => "MyString",
      :difficulty => "MyString",
      :user => nil,
      :post => nil
    ))
  end

  it "renders the edit spot form" do
    render

    assert_select "form[action=?][method=?]", spot_path(@spot), "post" do

      assert_select "input#spot_latitude[name=?]", "spot[latitude]"

      assert_select "input#spot_longitude[name=?]", "spot[longitude]"

      assert_select "input#spot_description[name=?]", "spot[description]"

      assert_select "input#spot_title[name=?]", "spot[title]"

      assert_select "input#spot_difficulty[name=?]", "spot[difficulty]"

      assert_select "input#spot_user_id[name=?]", "spot[user_id]"

      assert_select "input#spot_post_id[name=?]", "spot[post_id]"
    end
  end
end
