require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "should not be valid without a description" do
    book = Book.new(title: "Test Title", price: 10.99)
    assert_not book.valid?, "Book is valid without a description"
  end

  test "should be valid with all attributes" do
    book = Book.new(title: "Test Title", description: "Test Description", price: 10.99)
    assert book.valid?, "Book is not valid with all attributes"
  end

  test "should not be valid without a title" do
    book = Book.new(description: "Test Description", price: 10.99)
    assert_not book.valid?, "Book is valid without a title"
  end

  test "price should not be negative" do
    book = Book.new(title: "Test Title", description: "Test Description", price: -1)
    assert_not book.valid?, "Book is valid with a negative price"
  end
end
