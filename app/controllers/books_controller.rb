class BooksController < ApplicationController
  def top
  end

  def index
    @books = Book.all
    @book = current_user.books.new
    @tag_list = Tag.all
  end

  def create
    @book = current_user.books.build(book_params)
    tag_list = params[:book][:tag_name].split(nil) #送信されてきたタグの取得
    if @book.save
      @book.save_books(tag_list)
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_tags = @book.tags
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @books = @tag.books.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end