class AddDataSourceToNews < ActiveRecord::Migration
  def change
    add_reference :news, :data_source, index: true, foreign_key: true
  end
end
