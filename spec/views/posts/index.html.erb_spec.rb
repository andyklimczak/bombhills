require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      create(:image_post), create(:image_post), create(:video_post)
    ])
  end

  it "renders a list of posts" do
    render
    expect(rendered).to match("#DISCOVER")
    assert_select ".row>#thumbnailcontainer", :count => 3
  end
end
