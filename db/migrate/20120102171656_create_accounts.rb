class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.string :name, :null => false
      t.integer :campaign_limit, :null => false, :default => 1
      t.integer :campaigns_count, :null => false, :default => 0
      t.integer :users_count, :null => false, :default => 0
      t.integer :contact_limit, :null => false, :default => 50
      t.integer :user_limit, :null => false, :default => 3
      t.integer :messages_limit, :null => false, :default => 30
      t.boolean :active, :null => false, :default => true
    end
    
    add_index :accounts, [:active]    
  end

  def down
    drop_table :accounts
  end
end
