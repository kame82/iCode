class ChangeIsPublicToIntegerInCodes < ActiveRecord::Migration[7.1]
  def up
    # デフォルト値をnilに設定
    change_column_default :codes, :is_public, nil

    # is_publicをbooleanからintegerに変更する
    change_column :codes, :is_public, :integer, using: 'is_public::integer', default: 0
  end

  def down
    # integerからbooleanに戻す
    change_column :codes, :is_public, :boolean, using: 'is_public::boolean', default: true
  end
end
