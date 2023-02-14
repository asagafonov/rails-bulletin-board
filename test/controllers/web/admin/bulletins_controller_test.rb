# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:bob)
    @user = users(:chuck)

    @bulletin = bulletins(:pasta)
  end

  test 'admin should access index' do
    sign_in @admin
    get admin_bulletins_url
    assert_response :success
  end

  test 'user should not access index' do
    sign_in @user
    get admin_bulletins_url
    assert_redirected_to root_path
  end

  test 'admin should publish' do
    sign_in @admin

    patch publish_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert { @bulletin.state == 'published' }
  end
end
