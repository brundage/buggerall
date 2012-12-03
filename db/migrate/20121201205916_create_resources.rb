class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :path
    end
    add_index :resources, :path, unique: true
  end
end
