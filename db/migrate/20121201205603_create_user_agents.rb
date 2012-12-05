class CreateUserAgents < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.string :agent
      t.datetime :created_at
    end
    add_index :user_agents, :agent, unique: true
  end
end
