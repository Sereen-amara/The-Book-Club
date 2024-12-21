class DashboardController < ApplicationController
  def showcase
    @highlighted_books = Book.limit(3) # Fetch a few books to display as highlights
  end
end
