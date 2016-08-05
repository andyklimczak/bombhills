module SpotsHelper
  def difficulties
    ['Beginner', 'Intermediate', 'Professional'].map { |x| [x, x] }
  end
end
