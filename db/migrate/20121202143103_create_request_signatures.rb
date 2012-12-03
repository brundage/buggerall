class CreateRequestSignatures < ActiveRecord::Migration
  def change
    create_table :request_signatures do |t|
      t.string :accept
      t.string :accept_charset
      t.string :accept_encoding
      t.string :accept_language
      t.string :remote_ip
      t.references :resource_request
      t.timestamps
    end
    add_index :request_signatures, :accept
    add_index :request_signatures, :accept_charset
    add_index :request_signatures, :accept_encoding
    add_index :request_signatures, :accept_language
    add_index :request_signatures, :remote_ip
    add_index :request_signatures, :resource_request_id, unique: true
  end
end
