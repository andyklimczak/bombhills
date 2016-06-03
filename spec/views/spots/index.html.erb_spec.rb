require 'rails_helper'

RSpec.describe "spots/index", type: :view do
  before(:each) do
    assign(:spots, [
      create(:spot), create(:spot)
    ])
  end

  it "renders the map page" do
    render
    user = create(:user,username: 'user123', email: 'user@example.com', password: 'password123')
    sign_in user
    expect(rendered).to match("bombhills")
    expect(rendered).to match("Find Me")
    expect(rendered).to match("Login")
    expect(rendered).to match("DISCOVER")
    expect(rendered).to match("Hide")
  end

  it "renders the map page logged in" do
    user = create(:user,username: 'user123', email: 'user@example.com', password: 'password123')
    sign_in user
    render
    expect(rendered).to match("bombhills")
    expect(rendered).to match("Find Me")
    expect(rendered).to match("Profile")
    expect(rendered).to match("DISCOVER")
    expect(rendered).to match("Hide")
  end
end
