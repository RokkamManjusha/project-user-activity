class AddProjectActivity < ActiveRecord::Migration[6.1]
  def self.up
    create_table :project_activities do |t|
      t.string   :change_type, default: :comment
      t.string   :status
      t.references :comment, foreign_key: true, null: true
      t.references :project, foreign_key: true, null: false
      t.references :admin_user, foreign_key: true, null: false
      t.timestamps
    end
    add_index :project_activities, [:comment, :admin_user]
  end

  def self.down
    drop_table :project_activities
  end
end
