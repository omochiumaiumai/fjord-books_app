class CreateFollowRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_relations do |t|
      t.integer :follower_id, null: false
      t.integer :following_id, null: false

      t.timestamps
    end
    add_index :follow_relations, :follower_id
    add_index :follow_relations, :following_id
    add_index :follow_relations, %i[follower_id following_id], unique: true
  end
end
