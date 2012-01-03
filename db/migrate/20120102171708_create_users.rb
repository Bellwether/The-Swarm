class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.references :account, :null => false
      t.string :name, :null => false      
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.boolean :active, :null => false, :default => true
    end    
    
    add_index :users, [:active,:email]
    add_index :users, [:account_id] 
  end

  def down
    drop_table :users
  end
end
