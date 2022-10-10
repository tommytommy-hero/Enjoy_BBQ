class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|

      t.integer :recipe_id
      t.string :name, null: false

      t.timestamps
    end
  end
end
