require 'rails_helper'

RSpec.describe "spots/new", type: :view do
  before(:each) do
    assign(:spot, Spot.new(
      :latitude => "9.99",
      :longitude => "9.99",
      :description => "MyString",
      :title => "MyString",
      :difficulty => "MyString",
      :user => nil,
      :post => nil
    ))
  end

  it "renders new spot form" do
    render

    assert_select "form[action=?][method=?]", spots_path, "post" do

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
