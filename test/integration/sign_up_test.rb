require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest

  
  test "get signup form and create a new user" do 
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do 
      post_via_redirect users_path, user:{ username: "Gwenou", email: "gwenou@example.com", password:"gwenou"}
    end 
    assert_template 'users/show'
  end 
  
end 