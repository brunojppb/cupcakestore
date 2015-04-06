require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:bruno)
    @other_user = users(:rha)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect to login page if not logged in" do
    get :edit, id: @user.id
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user.id, user: { first_name: @user.first_name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user.id
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user.id, user: { first_name: @user.first_name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
