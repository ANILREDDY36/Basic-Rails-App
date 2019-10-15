# frozen_string_literal: true

# CreateWords migration
class AddLanguageToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :language, :string
  end
end
