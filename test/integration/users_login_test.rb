require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bruno)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    #test if the response redirected to the user page
    assert_redirected_to @user
    #Visit the target page
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    #Log out
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    #simulate a user clicking logout ins a second window (like other browser)
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", logout_path,       count: 0
    assert_select "a[href=?]", user_path(@user),  count: 0

  end
  
  test "login with invalild information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: "", password: ""}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with remembering' do
    log_in_as(@user, remember_me: '1')
    #inside tests, cookies does not accept symbols as keys
    #just strings
    assert_not_nil cookies['remember_token']
  end

  test 'login without remembering' do
    log_in_as(@user, remember_me: '0')
    #inside tests, cookies does not accept symbols as keys
    #just strings
    assert_nil cookies['remember_token']
  end
end
















