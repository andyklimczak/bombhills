require 'rails_helper'

RSpec.describe "posts/new", type: :view do

  it "renders new post form" do
    render
    expect(rendered).to match("Add Post")
  end
end
