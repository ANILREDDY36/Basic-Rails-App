class RemoveLangaugeFromWords < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :language, :string
  end
end
