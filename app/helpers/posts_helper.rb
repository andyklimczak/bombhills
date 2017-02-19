# frozen_string_literal: true
module PostsHelper
  def embed(youtube_url)
    youtube_id = youtube_id(youtube_url)
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}", frameborder: 0, width: 720, height: 405)
  end

  def preview(youtube_url)
    youtube_id = youtube_id(youtube_url)
    image_tag("//img.youtube.com/vi/#{youtube_id}/0.jpg", class: 'img-responsive')
  end

  private

  def youtube_id(youtube_url)
    youtube_url.split('=').last
  end
end
