# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://bombhills.com"

SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                                                    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                                                    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                    fog_directory: ENV['S3_BUCKET_NAME'],
                                                                    fog_region: ENV['S3_REGION'])

SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # Add index path
  add welcome_index_path, :changefreq => 'weekly'

  # Add '/spots'
  #
  add spots_path, :changefreq => 'daily'
  #
  # Add all spots and spots meetups:
  #
  Spot.find_each do |spot|
    add spot_path(spot), :lastmod => spot.updated_at
    add spot_meetups_path(spot), :lastmod => spot.updated_at
  end

  # Add '/posts'
  #
  add posts_path, :changefreq => 'daily'
  #
  # Add all posts:
  #
  Post.find_each do |post|
    add post_path(post), :lastmod => post.updated_at
  end

  #
  # Add all users:
  #
  User.find_each do |user|
    add show_user_path(user), :lastmod => user.updated_at
  end

  # Add '/meetups'
  #
  add meetups_path, :changefreq => 'daily'
  #
  # Add all posts:
  #
  Meetup.find_each do |meetup|
    add spot_meetup_path(meetup.spot, meetup), :lastmod => meetup.updated_at
  end
end
