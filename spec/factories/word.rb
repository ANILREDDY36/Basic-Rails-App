# frozen_string_literal: true

FactoryBot.define do
  factory :word do
    content { 'bat' }
    language
    user
  end
end
