require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # include SessionsHelper

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", users_path, count: 0
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")

    log_in_as @user
    assert_redirected_to @user
    follow_redirect!
    assert is_logged_in?
    assert_select "a[href=?]", users_path, count: 1

    # assert_equal @user, current_user
    # log_out
    # assert_not is_logged_in?


  end
end
