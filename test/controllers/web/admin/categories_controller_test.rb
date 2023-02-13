# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:bob)
    @user = users(:chuck)

    @category = categories(:tech)

    @params = {
      name: Faker::Lorem.sentence(word_count: 1)
    }
  end

  test 'admin should view categories' do
    sign_in @admin
    get admin_categories_url

    assert_response :success
  end

  test 'admin should create category' do
    sign_in @admin

    post admin_categories_url, params: { category: @params }

    category = Category.find_by(@params)

    assert { category }
  end

  test 'admin should edit category' do
    sign_in @admin

    patch admin_category_url(@category), params: { category: { name: 'Edited name' } }
    @category.reload

    assert { @category.name == 'Edited name' }
  end

  test 'common user should not access categories' do
    sign_in @user

    get admin_categories_url

    assert_redirected_to root_path
  end

  test 'common user should not create categories' do
    sign_in @user

    post admin_categories_url, params: { category: @params }

    category = Category.find_by(@params)

    assert { !category }
    assert_redirected_to root_path
  end

  test 'common user should not update categories' do
    sign_in @user

    patch admin_category_url(@category), params: { category: { name: 'Edited name' } }

    @category.reload

    assert { @category.name != 'Edited name' }
    assert_redirected_to root_path
  end

  test 'common user should not destroy categories' do
    sign_in @user

    delete admin_category_url(@category)

    assert { @category }
    assert_redirected_to root_path
  end
end
