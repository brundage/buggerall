class CreateBuggerallUserAgents < ActiveRecord::Migration
  def change
    create_table :buggerall_user_agents do |t|
      t.string :agent, null: false
      t.references :resource_request, null: false
      t.timestamps
    end
    add_index :buggerall_user_agents, :agent, unique: true
    add_index :buggerall_user_agents, :resource_request_id
  end
end
