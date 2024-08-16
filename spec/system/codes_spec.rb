require 'rails_helper'

RSpec.describe 'Codes', type: :system do
  include LoginMacros
  include CodeMacros

  before do
    driven_by(:rack_test)
  end
  # before do
  #   driven_by(:selenium_chrome_headless)
  # end

  let(:user) { create(:user) }
  let(:code) { create(:code, user: user) }

  describe 'コードCRUD機能' do
    context '正常系' do
      it 'HTML_コード登録機能のテスト' do
        login(user)
        codeSave(code)
        expect(page).to have_content I18n.t('flash.code.create')
        expect(Code.last.title).to eq('Title')
        expect(Code.last.body_html).to eq('BodyHtml')
      end

      it 'HTML_コード編集機能のテスト' do
        login(user)
        codeSave(code)
        visit edit_code_path(Code.last)
        fill_in 'code[title]', with: 'Title2'
        fill_in 'code[body_html]', with: 'BodyHtml2'
        click_on 'save'
        expect(page).to have_content I18n.t('flash.code.update')
        expect(Code.last.title).not_to eq('Title')
        expect(Code.last.body_html).not_to eq('BodyHtml')
        expect(Code.last.title).to eq('Title2')
        expect(Code.last.body_html).to eq('BodyHtml2')
      end

      it 'HTML_コード削除機能のテスト', :js do
        puts "Current Driver: #{Capybara.current_driver}"
        puts "JavaScript Driver: #{Capybara.javascript_driver}"
        login(user)
        codeSave(code)
        visit edit_code_path(Code.last)
        click_on 'delete'
        expect(current_path).to eq codes_path
        expect(page).to have_content I18n.t('flash.code.destroy')
        expect(Code.last.title).not_to eq('Title')
        expect(Code.last.body_html).not_to eq('BodyHtml')
      end
    end

    context '異常系' do
      it 'HTML_コード登録機能のテスト' do
        login(user)
        visit new_code_path
        fill_in 'code[title]', with: ''
        fill_in 'code[body_html]', with: ''
        click_on 'save'
        expect(page).to have_content I18n.t('errors.messages.blank')
      end

      it 'HTML_コード編集機能のテスト' do
        login(user)
        visit edit_code_path(code)
        fill_in 'code[title]', with: ''
        click_on 'save'
        expect(page).to have_content I18n.t('errors.messages.blank')
      end
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
