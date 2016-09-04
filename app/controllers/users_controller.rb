# frozen_string_literal: true
class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
  end
end
