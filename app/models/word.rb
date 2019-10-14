# frozen_string_literal: true

# word Active Model
class Word < ApplicationRecord
  validates :content, presence: true
end
