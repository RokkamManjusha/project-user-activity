class AddComments < ActiveRecord::Migration[6.1]
  def self.up
    create_table :comments do |t|
      t.text   :body
      t.references :project, foreign_key: true
      t.timestamps
    end
    add_index :comments, :project
  end

  def self.down
    drop_table :comments
  end
end
