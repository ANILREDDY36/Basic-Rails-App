# frozen_string_literal: true

# word Active Model
class Word < ApplicationRecord
  validates :value, :language, presence: true
end
