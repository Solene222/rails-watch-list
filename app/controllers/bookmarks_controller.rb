class BookmarksController < ApplicationController
  before_action :set_bookmarks, only: [:destroy]
  before_action :set_lists, only: [:new, :create]

  # def index
  #   @bookmarks = Bookmark.all
  # end

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_bookmarks_path
  end

  private
  def set_bookmarks
    @bookmark = Bookmark.find(params[:id])
  end

  def set_lists
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
