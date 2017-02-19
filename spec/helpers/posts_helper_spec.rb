# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  let(:youtube_url) { 'https://www.youtube.com/watch?v=c7rCyll5AeY' }

  describe '#embed' do
    it 'returns the embed url for a normal youtube url' do
      expect(helper.embed(youtube_url)).to eql('<iframe src="//www.youtube.com/embed/c7rCyll5AeY" frameborder="0" width="720" height="405"></iframe>')
    end
  end

  describe '#preview' do
    it 'returns the preview image for youtube video' do
      expect(helper.preview(youtube_url)).to eql('<img class="img-responsive" src="//img.youtube.com/vi/c7rCyll5AeY/0.jpg" alt="0" />')
    end
  end
end
