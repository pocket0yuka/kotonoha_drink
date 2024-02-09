# frozen_string_literal: true

require 'test_helper'

# HomesControllerTest  HomesController の統合テストを実行するためのテストクラス
class HomesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get homes_index_url
    assert_response :success
  end
end
