class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.references :user, :null => false   
      t.references :campaign, :null => false
      t.string :subject, :null => false, :limit => 99
      t.text :body
      t.string :message_arn      
      t.timestamp :created_at
    end
    
    add_index :messages, [:campaign_id]
  end

  def down
    drop_table :messages
  end
end
