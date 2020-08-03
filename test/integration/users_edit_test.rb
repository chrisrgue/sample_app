require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'

    # assert_select "div.nav" # matches <div class="nav">foobar</div>
    # assert_select "div.alert", users_edit_path, count: 3 # matches <div class="nav">foobar</div>
    assert_select "div.alert", "The form contains 4 errors."
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)

    # subseqent (superfluous) login should redirect to the profile page
    # of the already logged in user
    # (acc. to Chapter 10.2, Exercise 1, page 562)
    log_in_as(@user)
    assert_redirected_to @user

    # test "successful edit" do
    #   log_in_as(@user)
    #   get edit_user_path(@user)
    #   assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password:
                                              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end



end
