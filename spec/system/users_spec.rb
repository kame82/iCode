require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  context '正常系' do
    it 'ログイン/ログアウト機能のテスト' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button I18n.t('header.login')
      expect(page).to have_content I18n.t('header.logout')
      click_on I18n.t('header.logout')
      expect(page).to have_content I18n.t('header.login')
      expect(page).to have_no_content I18n.t('validation.required')
    end

    it 'ユーザー登録機能のテスト' do
      visit new_user_registration_path
      fill_in 'user[name]', with: 'test_user'
      fill_in 'user[email]', with: 'sample@email'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button I18n.t('header.signup')
      expect(page).to have_no_content I18n.t('validation.required')
    end
  end

  context '異常系' do
    it 'ユーザー登録機能のテスト nameバリ確認' do
      visit new_user_registration_path
      fill_in 'user[name]', with: ''
      fill_in 'user[email]', with: 'sample@email'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button I18n.t('header.signup')
      expect(page).to have_content I18n.t('errors.messages.blank')
    end

    it 'ユーザー登録機能のテスト emailバリ確認' do
      visit new_user_registration_path
      fill_in 'user[name]', with: 'test_user'
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button I18n.t('header.signup')
      expect(page).to have_content I18n.t('errors.messages.blank')
    end

    it 'ユーザー登録機能のテスト passwordバリ確認' do
      visit new_user_registration_path
      fill_in 'user[name]', with: 'test_user'
      fill_in 'user[email]', with: 'sample@email'
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: 'password'
      click_button I18n.t('header.signup')
      expect(page).to have_content I18n.t('errors.messages.confirmation',
                                          attribute: I18n.t('activerecord.attributes.user.password'))
    end

    it 'ユーザー登録機能のテスト password_confirmationバリ確認' do
      visit new_user_registration_path
      fill_in 'user[name]', with: 'test_user'
      fill_in 'user[email]', with: 'sample@email'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: ''
      click_button I18n.t('header.signup')
      expect(page).to have_content I18n.t('errors.messages.confirmation',
                                          attribute: I18n.t('activerecord.attributes.user.password'))
    end

    it 'ログイン機能のテスト password 文字数バリ確認' do
      visit new_user_registration_path
      fill_in 'user[name]', with: 'test_user'
      fill_in 'user[email]', with: 'sample@email'
      fill_in 'user[password]', with: '123'
      fill_in 'user[password_confirmation]', with: '123'
      click_button I18n.t('header.signup')
      expect(page).to have_content I18n.t('errors.messages.too_short', count: 6)
    end

    it 'ログイン機能のテスト email重複確認' do
      visit new_user_registration_path
      fill_in 'user[name]', with: 'test_user'
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '新規登録'
      expect(page).to have_content I18n.t('errors.messages.taken')
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
