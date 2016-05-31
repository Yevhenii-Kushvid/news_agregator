class CreateNewsTopics < ActiveRecord::Migration
  def change
    create_table :news_topics do |t|
      
      t.timestamps null: false
    end
  end
end
