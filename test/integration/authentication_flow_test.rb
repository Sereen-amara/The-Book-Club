require "test_helper"

class AuthenticationFlowTest < ActionDispatch::IntegrationTest
  test "unauthenticated user is redirected to login" do
    get books_url
    assert_redirected_to new_user_session_path
  end

  test "authenticated user can create a book" do
    sign_in users(:user_one)
    get new_book_url
    assert_response :success

    assert_difference("Book.count", 1) do
      post books_url, params: { book: { title: "Integration Test Book", description: "Created in test", price: 15.0 } }
    end
    assert_redirected_to book_url(Book.last)
  end
end
