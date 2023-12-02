require "application_system_test_case"

class StacksTest < ApplicationSystemTestCase
  setup do
    @stack = stacks(:one)
  end

  test "visiting the index" do
    visit stacks_url
    assert_selector "h1", text: "Stacks"
  end

  test "should create stack" do
    visit stacks_url
    click_on "New stack"

    fill_in "Share link", with: @stack.share_link
    fill_in "Title", with: @stack.title
    fill_in "User", with: @stack.user_id
    click_on "Create Stack"

    assert_text "Stack was successfully created"
    click_on "Back"
  end

  test "should update Stack" do
    visit stack_url(@stack)
    click_on "Edit this stack", match: :first

    fill_in "Share link", with: @stack.share_link
    fill_in "Title", with: @stack.title
    fill_in "User", with: @stack.user_id
    click_on "Update Stack"

    assert_text "Stack was successfully updated"
    click_on "Back"
  end

  test "should destroy Stack" do
    visit stack_url(@stack)
    click_on "Destroy this stack", match: :first

    assert_text "Stack was successfully destroyed"
  end
end
