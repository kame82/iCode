class FixUniqueIndexOnCodeTags < ActiveRecord::Migration[7.1]
  def change
    # 既存の一意制約インデックスを削除
    remove_index :code_tags, :tag_id

    # code_id と tag_id のペアに対して一意制約を追加
    add_index :code_tags, [:code_id, :tag_id], unique: true
  end
end
