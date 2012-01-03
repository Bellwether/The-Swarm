class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.references :account, :null => false
      t.string :name, :null => false
      t.string :email
      t.string :phone
      t.timestamp :created_at
    end
    
    add_index :contacts, [:account_id, :created_at]
  end

  def down
    drop_table :contacts
  end
end
