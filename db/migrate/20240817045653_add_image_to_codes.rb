class AddImageToCodes < ActiveRecord::Migration[7.1]
  def change
    add_column :codes, :image, :string
  end
end
