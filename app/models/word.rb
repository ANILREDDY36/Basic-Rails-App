# frozen_string_literal: true

# word Active Model
class Word < ApplicationRecord
  belongs_to :language
  belongs_to :user

  has_many :translations_association, class_name: 'Translation'
  has_many :translations, through: :translations_association, source: :translated_word
  has_many :inverse_translations_association, class_name: 'Translation', foreign_key: 'translated_word_id'
  has_many :inverse_translations, through: :inverse_translations_association, source: :word

  validates :content, :language, presence: true
  validate :translation_language_cannot_same_as_word_language
  accepts_nested_attributes_for :translations, allow_destroy: true

  paginates_per 5

  def translation_language_cannot_same_as_word_language
    return if translations.none? { |translation| translation.language == language }
    errors.add(:language, 'must be different from translation language')
  end
end
