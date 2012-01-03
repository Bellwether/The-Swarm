class CreateCampaigns < ActiveRecord::Migration
  def up
    create_table :campaigns do |t|
      t.references :account, :null => false
      t.integer :messages_count, :null => false, :default => 0
      t.string :name, :null => false
      t.string :topic_arn
      t.timestamp :created_at
    end

    add_index :campaigns, [:account_id, :created_at]    
    add_index :campaigns, [:topic_arn]
  end

  def down
    drop_table :campaigns
  end
end
