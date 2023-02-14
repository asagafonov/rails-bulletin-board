# frozen_string_literal: true

require 'test_helper'

class Web::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'unauthorized user should not access profile page' do
    get profile_url
    assert_redirected_to root_url
  end

  test 'autorized user should access profile page' do
    sign_in users(:bob)
    get profile_url
    assert_response :success
  end
end
