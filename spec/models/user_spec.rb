require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'emailが有効な場合はバリデーションを通過する' do
      user = create(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'emailが空の場合は無効である' do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
    end

    it 'emailが重複している場合は無効である' do
      user = create(:user)
      user2 = build(:user, email: 'user@sample.com')
      expect(user2).to be_invalid
      expect(user2.errors[:email]).to include(I18n.t('errors.messages.taken'))
    end

    pending "add some examples to (or delete) #{__FILE__}"
  end
end
