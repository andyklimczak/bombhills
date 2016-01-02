class Location < ActiveRecord::Base
  belongs_to :user
  validates :latitude, :longitude, :title, :difficulty, presence: true
	validates :difficulty,
			:inclusion  => { :in => ['Beginner', 'Intermediate', 'Expert'],
			:message    => "%{value} is not a valid difficulty" }

  def gon_object
    {
      user_email: self.user.email,
      descripton: self.description,
      title: self.title,
      difficulty: self.difficulty
    }
  end
end
