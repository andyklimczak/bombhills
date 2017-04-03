# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpotsHelper, type: :helper do
  describe '#difficulties' do
    it 'returns nested array of difficulties to use with select elements' do
      expect(helper.difficulties).to eql([%w[Beginner Beginner], %w[Intermediate Intermediate], %w[Professional Professional]])
    end
  end
end
