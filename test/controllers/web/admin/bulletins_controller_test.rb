# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:bob)
    @user = users(:chuck)

    @bulletin = bulletins(:pasta)
  end

  test 'admin should access root' do
    sign_in @admin
    get admin_root_url
    assert_response :success
  end

  test 'user should not access root' do
    sign_in @user
    get admin_root_url
    assert_redirected_to root_url
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

    assert @bulletin.published?
    assert_redirected_to admin_root_url
  end

  test 'user should not publish' do
    sign_in @user

    patch publish_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert @bulletin.under_moderation?
    assert_redirected_to root_url
  end

  test 'admin should reject' do
    sign_in @admin

    patch reject_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert @bulletin.rejected?
    assert_redirected_to admin_root_url
  end

  test 'user should not reject' do
    sign_in @user

    patch reject_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert @bulletin.under_moderation?
    assert_redirected_to root_url
  end

  test 'admin should archive' do
    sign_in @admin

    patch archive_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert @bulletin.archived?
    assert_redirected_to admin_root_url
  end

  test 'admin should archive from bulletins section and return there' do
    sign_in @admin

    patch archive_admin_bulletin_url(@bulletin, fallback_url: admin_bulletins_url)

    @bulletin.reload

    assert @bulletin.archived?
    assert_redirected_to admin_bulletins_url
  end

  test 'user should not archive via admin route' do
    sign_in @user

    patch archive_admin_bulletin_url(@bulletin)

    @bulletin.reload

    assert @bulletin.under_moderation?
    assert_redirected_to root_url
  end
end
