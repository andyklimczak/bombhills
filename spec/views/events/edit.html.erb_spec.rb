=begin

require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :title => "MyString",
      :description => "MyString",
      :datetime => ""
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_title[name=?]", "event[title]"

      assert_select "input#event_description[name=?]", "event[description]"

      assert_select "input#event_datetime[name=?]", "event[datetime]"
    end
  end
end


=end