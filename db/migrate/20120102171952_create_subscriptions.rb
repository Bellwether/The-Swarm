class CreateSubscriptions < ActiveRecord::Migration
  def up
    create_table :subscriptions do |t|
      t.references :campaign, :null => false
      t.references :contact, :null => false
      t.string :endpoint, :null => false
      t.string :protocol, :null => false
      t.string :subscription_arn
      t.timestamp :created_at
    end
    
    add_index :subscriptions, [:campaign_id]
    add_index :subscriptions, [:contact_id]
    add_index :subscriptions, [:protocol]    
  end

  def down
    drop_table :subscriptions
  end
end