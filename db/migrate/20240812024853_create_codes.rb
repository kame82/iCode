class CreateCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :codes do |t|
      t.string :title , null: false
      t.text :body_html
      t.text :body_css
      t.text :body_js
      t.boolean :is_public , null: false , default: true

      t.timestamps
    end
  end
end
