require "application_system_test_case"

class BooksSystemTest < ApplicationSystemTestCase
  test "user creates a book" do
    visit new_book_path
    fill_in "Title", with: "System Test Book"
    fill_in "Description", with: "System test description"
    fill_in "Price", with: 20.0
    click_button "Create Book"

    assert_text "Book was successfully created."
    assert_text "System Test Book"
  end

  test "user deletes a book" do
    visit books_path
    within "tr", text: books(:one).title do
      click_link "Delete"
    end
    assert_text "Book was successfully deleted."
  end
end
