require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {first_name:             "", 
                              last_name:              "",
                              phone_number:           "",
                              email:                  "user@invalid",
                              password:                "foo",
                              password_confirmation:  "bar" }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { first_name:              "first name",
                                            last_name:              "last name",
                                            email:                  "firstname@gmail.com",
                                            phone_number:           "83-3233-6935",
                                            password:               "foobar",
                                            password_confirmation:  "foobar" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end

end