class Location < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :latitude, :longitude, :title, :difficulty, presence: true
	validates :difficulty,
			:inclusion  => { :in => ['Beginner', 'Intermediate', 'Expert'],
			:message    => "%{value} is not a valid difficulty" }
end
