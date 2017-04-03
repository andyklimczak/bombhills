# frozen_string_literal: true

module SpotsHelper
  def difficulties
    Spot.difficulties.keys.map { |x| [x, x] }
  end
end
