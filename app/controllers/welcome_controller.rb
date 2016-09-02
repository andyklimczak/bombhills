# frozen_string_literal: true
class WelcomeController < ApplicationController
  def index
    @posts = ImagePost.limit 3
  end
end
