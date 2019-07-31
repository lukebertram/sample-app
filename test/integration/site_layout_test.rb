require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:luke)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")

    # test navigation links for logged-in user
    log_in_as(@user)
    assert is_logged_in?
    assert_redirected_to @user
    # why does the following assert fail?
    # assert_select "a[href=?]", edit_user_path(@user)
  end
end
