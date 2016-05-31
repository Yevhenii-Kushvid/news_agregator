class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :title,       presence: true
      t.text :link,        presence: true, unique: true
      t.text :description, presence: true
      t.text :text

      t.timestamps null: false
    end
  end
end
