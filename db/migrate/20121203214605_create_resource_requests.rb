class CreateResourceRequests < ActiveRecord::Migration
  def change
    create_table :resource_requests do |t|
      t.references :request_signature, null: false
      t.references :resource, null: false
      t.timestamps
    end
    add_index :resource_requests, :request_signature_id
    add_index :resource_requests, :resource_id
  end
end
