# frozen_string_literal: true

class Word < ApplicationRecord
  validates :value, :language, presence: true
end
