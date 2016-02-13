class Post < ActiveRecord::Base
  belongs_to :user
  has_one :spot
  validates :image, presence: true
end
