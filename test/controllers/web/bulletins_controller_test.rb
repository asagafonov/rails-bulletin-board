# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bob)
    sign_in @user
    @category = categories(:tech)

    @params = {
      title: 'MacBook Air 13 M2',
      description: '256 GB SSD, 8 GB RAM',
      category_id: @category.id,
      user_id: @user.id
    }

    @attachments = {
      image: fixture_file_upload('phone.jpeg', 'image/jpeg')
    }
  end

  test 'should load index' do
    get bulletins_url
    assert_response :success
  end

  test 'should load new' do
    get new_bulletin_url
    assert_response :success
  end

  test 'should create bulletin' do
    post bulletins_url, params: { bulletin: @params.merge(@attachments) }
    bulletin = Bulletin.find_by(@params)

    assert { bulletin }
    assert { bulletin.image.attached? }
    assert_redirected_to bulletin_path(bulletin)
  end
end
