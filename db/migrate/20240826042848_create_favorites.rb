class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.integer :code_id
      t.integer :user_id

      t.timestamps
    end
  end
end
