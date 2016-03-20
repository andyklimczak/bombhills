# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  motto                  :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
  has_attached_file :avatar, styles: { large: "800x800#", medium: "300x300>", thumb: "100x100>" }, default_url: "https://placehold.it/500x500"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :spots, -> { order 'created_at desc' }
  has_many :posts, -> { order 'created_at desc' }
	validates :username,
		:presence => true,
		:uniqueness => {
			:case_sensitive => false
		}
	validate :validate_username

	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
		else
			conditions[:email].downcase! if conditions[:email]
			where(conditions.to_hash).first
		end
	end

	def validate_username
		if User.where(email: username).exists?
			errors.add(:username, :invalid)
		end
	end
end
