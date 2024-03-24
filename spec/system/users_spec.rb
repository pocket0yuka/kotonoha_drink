require 'rails_helper'

RSpec.describe "Users", type: :system do

  describe 'ユーザー登録処理' do
    context 'フォームの入力値が正常' do
      it '登録処理が成功すること' do
        visit new_user_registration_path # Deviseの登録ページに変更
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@email.com'
        fill_in 'user_password', with:  'password'
        fill_in 'user_password_confirmation', with:  'password'
        click_button '新規登録' # 実際のボタンテキストに合わせて変更
        expect(page).to have_content 'アカウント登録が完了しました。' # Deviseのデフォルトの成功メッセージに変更
        # リダイレクト後のパスをアプリケーションの設定に合わせて変更
      end
    end

    context 'フォームの入力値に誤りがある' do
      it '登録処理が失敗すること' do
        visit new_user_registration_path
        fill_in 'user_name', with: '' # 実際のフィールド名に合わせて変更
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: ''
        click_button '新規登録' # 実際のボタンテキストに合わせて変更
        expect(page).to have_content '2 件のエラーが発生した為 ユーザ は保存されませんでした。' # Deviseのデフォルトのエラーメッセージに変更
        expect(current_path).to eq user_registration_path # Deviseの登録ページのパスに合わせて変更
      end
    end
  end
end
