class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all.order(params[:sort])
    @book = Book.new
    @user = current_user
    @book_comment = BookComment.new

    if params[:category_id]
      # Categoryのデータベースのテーブルから一致するidを取得
      @category = Category.find(params[:category_id])

      # category_idと紐づく投稿を取得
      @books = @category.books.order(created_at: :desc).all
    else
      # 投稿すべてを取得
      @books = Book.order(created_at: :desc).all
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def search
    @category = Category.search(params[:search])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star, :sort, :category_id)
  end

end
