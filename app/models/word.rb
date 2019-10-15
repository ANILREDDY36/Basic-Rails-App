# frozen_string_literal: true

# word Active Model
class Word < ApplicationRecord
  belongs_to :language
  validates :content, :language, presence: true
end
