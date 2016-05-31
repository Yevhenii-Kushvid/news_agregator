class AddConnectionsToNewsTopic < ActiveRecord::Migration
  def change
    add_reference :news_topics, :news, index: true, foreign_key: true
    add_reference :news_topics, :topic, index: true, foreign_key: true
  end
end
