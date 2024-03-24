require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:drink) { FactoryBot.create(:drink) }

  describe 'ログイン処理' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功すること' do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: 'password' # FactoryBotで指定したパスワード
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'フォームの入力値に誤りがある' do
      it 'ログイン処理が失敗すること' do
        visit new_user_session_path
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
  end
end
