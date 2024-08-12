class AddUserRefToCode < ActiveRecord::Migration[7.1]
  def change
    add_reference :codes, :user, null: false, foreign_key: true
  end
end
