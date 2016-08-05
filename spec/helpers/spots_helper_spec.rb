require 'rails_helper'

RSpec.describe SpotsHelper, type: :helper do
  describe "#difficulties" do
    it "returns nested array of difficulties to use with select elements" do
      expect(helper.difficulties).to eql([['Beginner', 'Beginner'],['Intermediate', 'Intermediate'],['Professional', 'Professional']])
    end
  end
end
