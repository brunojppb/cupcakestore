require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:bruno)
  end

  test "should unsuccessfuly edit user" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { first_name:             '', 
                                    last_name:              '',
                                    email:                  'bar@invalid',
                                    phone_number:           '',
                                    password:               'foo',
                                    password_confirmation:  'bar' }
    assert_template 'users/edit'
  end

  test "should successfuly edit user" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    first_name = 'Carlos'
    email = 'carlosnew@gmail.com'
    patch user_path(@user), user: {  first_name:             first_name, 
                                      last_name:              @user.last_name,
                                      email:                  email,
                                      phone_number:           @user.phone_number,
                                      password:               '',
                                      password_confirmation:  '' }

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.first_name,  first_name
    assert_equal @user.email, email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    first_name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { first_name:             first_name,
                                    email:                  email,
                                    password:               'foobar',
                                    password_confirmation:  'foobar' }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.first_name,  first_name
    assert_equal @user.email,       email
  end


end






















