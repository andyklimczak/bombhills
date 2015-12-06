class Location < ActiveRecord::Base
  belongs_to :user

  def gon_object
    {
      user_email: self.user.email,
      descripton: self.description,
      title: self.title,
      difficulty: self.difficulty
    }
  end
end
