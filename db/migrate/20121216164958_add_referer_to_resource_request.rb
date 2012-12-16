class AddRefererToResourceRequest < ActiveRecord::Migration
  def change
    create_table :http_referrers do |t|
      t.string :url
    end
    add_index :http_referrers, :url

    add_column :resource_requests, :http_referrer_id, :integer
    add_index :resource_requests, :http_referrer_id
  end
end
