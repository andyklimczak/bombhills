require 'rails_helper'

RSpec.describe "welcome/index", type: :view do
  it "renders the route page" do
    render
    expect(rendered).to match("bombhills")
  end
end
