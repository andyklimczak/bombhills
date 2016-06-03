require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before :each do
    @user = create(:user, username: 'Username', email: 'user@example.com', password: 'password123')
  end

  it "render the user profile page" do
    render
    expect(rendered).to match("Username")
  end
end
