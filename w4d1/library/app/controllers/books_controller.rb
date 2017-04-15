class BooksController < ApplicationController
  def index
    @books = Book.all
  end

#The new action's job is just to render the page with the form to add a book
  def new
    render :new
  end


#create is what will actually save that new book with the parameters we give it to the database.
  def create
    @book = Book.new(book_params)
    @book.save!
    # render "New Book Created!"
    redirect_to books_url
  end

  def destroy
    selected = Book.find(params[:id])
    selected.destroy
    # fail
    redirect_to books_url
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end

=begin
the new template has already been made for you and is located at app/views/books/new.html.erb
the create action needs to redirect_to the index page if we want to see our new book added to the library
you can hit the :new route by either clicking on the 'Add a book!' link or navigating directly to localhost:3000/books/new
our create action has access to the values submitted through the new book form via the private book_params method provided for you in the BooksController
=end
