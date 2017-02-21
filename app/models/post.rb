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

class Post < ApplicationRecord
  include FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  acts_as_commentable
  belongs_to :user
  belongs_to :spot
  default_scope { order(created_at: :desc) }
  validates :title, :description, :type, presence: true

  def should_generate_new_friendly_id?
    title_changed?
  end
end
