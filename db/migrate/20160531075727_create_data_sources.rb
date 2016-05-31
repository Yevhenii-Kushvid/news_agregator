class CreateDataSources < ActiveRecord::Migration
  def change
    create_table :data_sources do |t|
      t.string :name,      presence: true
      t.text :link,        presence: true, unique:true
      t.text :description

      t.timestamps null: false
    end
  end
end
