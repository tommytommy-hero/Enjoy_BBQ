class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id, null: false
      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
