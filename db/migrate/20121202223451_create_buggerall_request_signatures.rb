class CreateBuggerallRequestSignatures < ActiveRecord::Migration
  def change
    create_table :buggerall_request_signatures do |t|
      t.string :accept
      t.string :accept_charset
      t.string :accept_encoding
      t.string :accept_language
      t.string :remote_ip, null: false
      t.references :resource_request, null: false
      t.timestamps
    end
    add_index :buggerall_request_signatures, :accept
    add_index :buggerall_request_signatures, :accept_charset
    add_index :buggerall_request_signatures, :accept_encoding
    add_index :buggerall_request_signatures, :accept_language
    add_index :buggerall_request_signatures, :remote_ip
    add_index :buggerall_request_signatures, :resource_request_id, unique: true
  end
end
