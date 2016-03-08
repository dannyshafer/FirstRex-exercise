require 'test_helper'

class BaseUsersControllerTest < ActionController::TestCase
  setup do
    @base_user = base_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_user" do
    assert_difference('BaseUser.count') do
      post :create, base_user: { current_month_engagement: @base_user.current_month_engagement, other: @base_user.other, previous_month_engagement: @base_user.previous_month_engagement, role: @base_user.role }
    end

    assert_redirected_to base_user_path(assigns(:base_user))
  end

  test "should show base_user" do
    get :show, id: @base_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @base_user
    assert_response :success
  end

  test "should update base_user" do
    patch :update, id: @base_user, base_user: { current_month_engagement: @base_user.current_month_engagement, other: @base_user.other, previous_month_engagement: @base_user.previous_month_engagement, role: @base_user.role }
    assert_redirected_to base_user_path(assigns(:base_user))
  end

  test "should destroy base_user" do
    assert_difference('BaseUser.count', -1) do
      delete :destroy, id: @base_user
    end

    assert_redirected_to base_users_path
  end
end
