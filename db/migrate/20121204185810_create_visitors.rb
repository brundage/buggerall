class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.timestamps
    end
    alter_table :request_signatures do |t|
      t.references :visitor
    end
    add_index :request_signatures, :visitor_id
  end
end
