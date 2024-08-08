require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it '設定したバリデーションが機能しているか(user)' do
      user = create(:user)
      user2 = build(:user, email: 'user@sample.com')
      expect(user).to be_valid
      expect(user.errors).to be_empty
      expect(user2).to be_valid
    end

    it 'バリデーションの一意性が機能しているか' do
      user = create(:user)
      expect(user).to be_valid

      user2 = build(:user)
      expect(user2).to be_invalid
      expect(user2.errors.messages[:email]).to include(I18n.t('errors.messages.taken'))
    end

    pending "add some examples to (or delete) #{__FILE__}"
  end
end
