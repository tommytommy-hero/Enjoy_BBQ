class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.text :content, null: false
      t.text :memo
      t.integer :process_status, null: false, default: 0

      t.timestamps
    end
  end
end
