# frozen_string_literal: true
module PostsHelper
  def embed(youtube_url)
    youtube_id = youtube_url.split('=').last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}", frameborder: 0)
  end
end
