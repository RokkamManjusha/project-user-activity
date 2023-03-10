class CreateProjects < ActiveRecord::Migration[6.1]
  def self.up
    create_table :projects do |t|
      t.string :title
      t.string :reference_number
      t.text   :description
      t.string :status, default: :unassigned
      t.references :admin_user, foreign_key: true
      t.timestamps
    end
    add_index :projects, :reference_number, unique: true
    add_index :projects, :admin_users
  end

  def self.down
    drop_table :projects
  end
end
