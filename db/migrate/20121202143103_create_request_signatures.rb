class CreateRequestSignatures < ActiveRecord::Migration
  def change
    create_table :request_signatures do |t|
      t.string :accept
      t.string :accept_charset
      t.string :accept_encoding
      t.string :accept_language
      t.string :checksum, null: false, limit: 128
      t.string :remote_ip, null: false, limit: 15
      t.references :user_agent, null: false
      t.timestamps
    end
    add_index :request_signatures, [:accept, :accept_charset, :accept_encoding, :accept_language, :remote_ip], name: 'index_accept_checksum'
    add_index :request_signatures, :checksum, unique: true
    add_index :request_signatures, :user_agent_id, unique: true
  end
end
