class CreateBuggerallResources < ActiveRecord::Migration
  def change
    create_table :buggerall_resources do |t|
      t.string :path, null: false
    end
    add_index :buggerall_resources, :path, unique: true
  end
end
