class AddCategoryToDataSource < ActiveRecord::Migration
  def change
    add_reference :data_sources, :category, index: true, foreign_key: true
  end
end
