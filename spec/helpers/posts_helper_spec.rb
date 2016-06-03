require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  describe "#embed" do
    it "returns the embed url for a normal youtube url" do
      youtube_url = "https://www.youtube.com/watch?v=c7rCyll5AeY"
      expect(helper.embed(youtube_url)).to eql('<iframe src="//www.youtube.com/embed/c7rCyll5AeY" frameborder="0"></iframe>')
    end
  end
end
