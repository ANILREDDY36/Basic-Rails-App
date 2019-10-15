# frozen_string_literal: true

# CreateWords migration
class RemoveLanguageFromWords < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :language
  end
end
