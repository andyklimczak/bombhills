# frozen_string_literal: true
# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :text
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  spot_id            :integer
#  type               :string
#  video_url          :string
#  slug               :string
#
# Indexes
#
#  index_posts_on_slug     (slug) UNIQUE
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class ImagePost < Post
  has_attached_file :image, styles: { thumb: '400x400>' }, default_url: 'https://placehold.it/150x150'
  validates_attachment :image, presence: true, content_type: { content_type: %r{\Aimage\/.*\Z} }, size: { in: 0..10.megabytes }
  default_scope { order(created_at: :desc) }
end
