require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one) # Assuming fixtures are set up
    @user = users(:user_one) # Assuming you have user fixtures
    sign_in @user # Log in the user before each test
  end

  test "should get index" do
    get books_url
    assert_response :success
    assert_select "h1", text: "Books", message: "Index page should display a heading with 'Books'"
    assert_select "table.table", message: "Index page should contain a table of books"
    assert_select "a[href=?]", new_book_path, text: "Add New Book", message: "Index page should have a link to add a new book"
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
    assert_select "h2", text: @book.title, message: "Show page should display the book title as a heading"
    assert_select "p", text: /Description:/, message: "Show page should display the book description label"
    assert_select "p", text: /#{@book.description}/, message: "Show page should display the book description"
    assert_select "p", text: /Price:/, message: "Show page should display the book price label"
  end


  test "should create book" do
    assert_difference("Book.count", 1, "Creating a book should increase the book count by 1") do
      post books_url, params: { book: { title: "New Book", description: "A test book", price: 9.99 } }
    end
    assert_redirected_to book_url(Book.last), "After creating a book, user should be redirected to the book's show page"
    follow_redirect!
    assert_select "h2", "New Book", "The show page should display the newly created book title"
  end


  test "should update book" do
    patch book_url(@book), params: { book: { title: "Updated Title" } }
    assert_redirected_to book_url(@book), "After updating a book, user should be redirected to the book's show page"
    follow_redirect!
    assert_select "h2", "Updated Title", "The show page should display the updated book title"
  end

  test "should destroy book" do
    assert_difference("Book.count", -1, "Destroying a book should decrease the book count by 1") do
      delete book_url(@book)
    end
    assert_redirected_to books_url, "After destroying a book, user should be redirected to the books index page"
  end

  test "should not create book without required fields" do
    assert_no_difference("Book.count") do
      post books_url, params: { book: { title: "", description: "", price: nil } }
    end
    assert_response :unprocessable_entity
  end
  test "should not save book without title" do
    book = Book.new(description: "Test Description", price: 10.0)
    assert_not book.save, "Saved the book without a title"
  end
  test "should not save book with negative price" do
    book = Book.new(title: "Invalid Price", description: "Test Description", price: -5.0)
    assert_not book.save, "Saved the book with a negative price"
  end

end
