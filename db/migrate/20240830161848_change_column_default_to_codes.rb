class ChangeColumnDefaultToCodes < ActiveRecord::Migration[7.1]
  def change
    change_column_default :codes, :title, from: nil, to: 'untitled'
  end
end
