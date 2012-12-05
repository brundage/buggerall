class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.timestamps
    end
    add_column :request_signatures, :visitor_id, :integer
    add_index :request_signatures, :visitor_id
  end
end
