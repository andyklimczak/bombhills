# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  describe '#embed' do
    it 'returns the embed url for a normal youtube url' do
      youtube_url = 'https://www.youtube.com/watch?v=c7rCyll5AeY'
      expect(helper.embed(youtube_url)).to eql('<iframe src="//www.youtube.com/embed/c7rCyll5AeY" frameborder="0"></iframe>')
    end
  end
end
