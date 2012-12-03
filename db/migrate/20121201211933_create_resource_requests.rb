class CreateResourceRequests < ActiveRecord::Migration
  def change
    create_table :resource_requests do |t|
      t.string :http_referer
      t.string :remote_ip
      t.string :request_uuid
      t.references :resource
      t.references :user
      t.references :user_agent
      t.timestamps
    end
    add_index :resource_requests, :http_referer
    add_index :resource_requests, :request_uuid, unique: true
    add_index :resource_requests, :resource_id
    add_index :resource_requests, :user_id
    add_index :resource_requests, :user_agent_id
  end
end
