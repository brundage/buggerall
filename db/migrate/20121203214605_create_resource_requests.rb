class CreateResourceRequests < ActiveRecord::Migration
  def change
    create_table :resource_requests do |t|
      t.references :request_signature, null: false
      t.references :resource, null: false
      t.string :uuid, null: false
      t.datetime :created_at
    end
    add_index :resource_requests, :request_signature_id
    add_index :resource_requests, :resource_id
    add_index :resource_requests, :uuid, unique: true
  end
end
