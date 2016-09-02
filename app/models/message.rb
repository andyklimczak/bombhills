# frozen_string_literal: true
class Message
  include ActiveModel::Model
  attr_accessor :name, :email, :content, :subject
  validates :name, :email, :content, :subject, presence: true
end
