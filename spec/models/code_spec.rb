require 'rails_helper'

RSpec.describe Code, type: :model do
  context 'validations' do
    it 'titleが有効な場合はバリデーションを通過する' do
      code = create(:code)
      expect(code).to be_valid
      expect(code.errors).to be_empty
    end

    it 'titleが空の場合は無効である' do
      code = build(:code, title: nil)
      expect(code).to be_invalid
      expect(code.errors[:title]).to include(I18n.t('errors.messages.blank'))
    end

    it 'titleが100文字を超える場合は無効である' do
      code = build(:code, title: 'MyString' * 100)
      expect(code).to be_invalid
      expect(code.errors[:title]).to include(I18n.t('errors.messages.too_long', count: 20))
    end

    it '異なるtitleを持つcodeが有効である' do
      code = create(:code)
      code2 = build(:code, title: 'MyString2')
      expect(code2).to be_valid
      expect(code2.errors).to be_empty
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
