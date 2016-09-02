# frozen_string_literal: true
module SpotsHelper
  def difficulties
    %w(Beginner Intermediate Professional).map { |x| [x, x] }
  end
end
