# == Schema Information
#
# Table name: spots
#
#  id          :integer          not null, primary key
#  latitude    :decimal(30, 25)
#  longitude   :decimal(30, 25)
#  description :string
#  title       :string
#  difficulty  :string
#  user_id     :integer
#  post_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_spots_on_post_id  (post_id)
#  index_spots_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_86567ce2ee  (post_id => posts.id)
#  fk_rails_f05e659f8c  (user_id => users.id)
#

class Spot < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :latitude, :longitude, :title, :difficulty, presence: true
	validates :difficulty,
			:inclusion  => { :in => ['Beginner', 'Intermediate', 'Expert'],
			:message    => "%{value} is not a valid difficulty" }
end
