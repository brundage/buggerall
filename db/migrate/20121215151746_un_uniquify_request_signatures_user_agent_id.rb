class UnUniquifyRequestSignaturesUserAgentId < ActiveRecord::Migration
  def up
    remove_index :request_signatures, :user_agent_id
    add_index :request_signatures, :user_agent_id
  end

  def down
    # don't care
  end
end
