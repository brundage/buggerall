class CreateBuggerallResourceRequests < ActiveRecord::Migration
  def change
    create_table :buggerall_resource_requests do |t|
      t.string :http_referer
      t.string :remote_ip
      t.string :request_uuid
      t.references :resource
      t.references :user_agent
      t.timestamps
    end
    add_index :buggerall_resource_requests, :http_referer
    add_index :buggerall_resource_requests, :request_uuid, unique: true
    add_index :buggerall_resource_requests, :resource_id
    add_index :buggerall_resource_requests, :user_agent_id
  end
end
