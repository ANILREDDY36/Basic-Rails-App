# frozen_string_literal: true

# word Active Model
class Language < ApplicationRecord
  has_many :words
  validates :name, presence: true
  validates :name, inclusion: { in: LanguageList::COMMON_LANGUAGES.map(&:name) }
end
