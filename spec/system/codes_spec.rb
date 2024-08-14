require 'rails_helper'

RSpec.describe 'Codes', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  let(:code) { create(:code, user: user) }

  describe 'コード登録機能', :js do
    context '正常系' do
      xit 'HTML_コード登録機能のテスト' do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit new_code_path
        fill_in 'code[title]', with: 'Title'
        fill_in 'code[body_html]', with: 'BodyHtml'
        click_on 'save'
        expect(page).to have_content '登録完了しました'
        expect(Code.last.title).to eq('Title')
        expect(Code.last.body_html).to eq('BodyHtml')
      end
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
