class BooksController < ApplicationController
  before_action :load_book, except: [:index, :new, :create]

  def index
    @books = Book.info_book.order(id: :asc).page(params[:page]).per(Settings.perpage)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "controller.books_controller.create_book"
      redirect_to @book
    else
      render :new
    end
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "controller.books_controller.update_book"
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "controller.books_controller.delete_book"
      redirect_to books_url
    else
      render :index
    end
  end

  private

  def load_book
    @book = Book.find_by_id params[:id]
    return if @book
    flash[:danger] = t "controller.books_controller.no_find_book"
    redirect_to root_path
  end

  def book_params
    params.require(:book).permit :name, :picture, :price, :author_id, :status, :categories_id, :publisher_id
  end
end