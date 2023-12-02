require "test_helper"

class StacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stack = stacks(:one)
  end

  test "should get index" do
    get stacks_url
    assert_response :success
  end

  test "should get new" do
    get new_stack_url
    assert_response :success
  end

  test "should create stack" do
    assert_difference("Stack.count") do
      post stacks_url, params: { stack: { share_link: @stack.share_link, title: @stack.title, user_id: @stack.user_id } }
    end

    assert_redirected_to stack_url(Stack.last)
  end

  test "should show stack" do
    get stack_url(@stack)
    assert_response :success
  end

  test "should get edit" do
    get edit_stack_url(@stack)
    assert_response :success
  end

  test "should update stack" do
    patch stack_url(@stack), params: { stack: { share_link: @stack.share_link, title: @stack.title, user_id: @stack.user_id } }
    assert_redirected_to stack_url(@stack)
  end

  test "should destroy stack" do
    assert_difference("Stack.count", -1) do
      delete stack_url(@stack)
    end

    assert_redirected_to stacks_url
  end
end
