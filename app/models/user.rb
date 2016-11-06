# frozen_string_literal: true
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


class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_messageable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login

  has_many :spots, -> { order 'created_at desc' }
  has_many :posts, -> { order 'created_at desc' }
  has_many :meetups
  has_many :meetup_attendees
  has_many :attending_meetups, through: :meetup_attendees, source: 'meetup'
  has_attached_file :avatar, styles: { large: '800x800#', medium: '300x300>', thumb: '100x100#' }, default_url: ->(_attachment) { ActionController::Base.helpers.asset_path('usertwo.png') }

  after_create :signup_notification

  validates_attachment :avatar, content_type: { content_type: %r{\Aimage\/.*\Z} }, size: { in: 0..5.megabytes }
  validate :validate_username
  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login.nil?
      email = conditions[:email].dup
      conditions[:email] = email.downcase if conditions[:email]
      find_by(conditions.to_hash)
    else
      find_by(['lower(username) = :value OR lower(email) = :value', { value: login }])
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    elsif username.present? && username.include?('.')
      errors.add(:username, :invalid)
    end
  end

  def name
    username
  end

  def mailboxer_email(_object)
    email
  end

  def signup_notification
    SignupMailer.signup_notification(self).deliver
  end

  def avatar_url
    avatar.url(:thumb)
  end
end
