require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :title => "MyString",
      :description => "MyString",
      :datetime => ""
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_title[name=?]", "event[title]"

      assert_select "input#event_description[name=?]", "event[description]"

      assert_select "input#event_datetime[name=?]", "event[datetime]"
    end
  end
end
