require 'test_helper'

class UserIndexTest < ActionDispatch::IntegrationTest
  
  def setup
  	@admin 	   = users(:luke)
  	@non_admin = users(:archer)
  end

  test "index including pagination and delete links" do
  	log_in_as(@admin)
  	get users_path
  	assert_template 'users/index'
  	assert_select 'div.pagination', count: 2
  	first_page_of_users = User.paginate(page: 1)
  	first_page_of_users.each do |user|
  		assert_select 'a[href=?]', user_path(user), text: user.name
  		unless user == @admin
  			assert_select 'a[href=?]', user_path(user), text: 'delete'
  		end
  	end
  	assert_difference 'User.count', -1 do
  		delete user_path(@non_admin)
  	end
  end

  test "index as non-admin" do
  	log_in_as(@non_admin)
  	get users_path
  	assert_select 'a', text: 'delete', count: 0
  end

  test "index should not show non-activated users" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    unactivated_user = User.find_by(email: "user@example.com")
    assert_not unactivated_user.activated?
    log_in_as(@non_admin)
    get users_path(:page => 2)
    assert_template 'users/index'
    # assert that the new, non-activated user is not present
    assert_select 'a[href=?]', user_path(unactivated_user), text: unactivated_user.name, count: 0
    # trying to view a non-activated user should reroute to index
    get user_path(unactivated_user)
    assert_redirected_to root_url
  end
end
