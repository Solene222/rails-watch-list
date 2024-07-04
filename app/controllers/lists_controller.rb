class ListsController < ApplicationController
  before_action :set_lists, only: [:show]
  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(params_list)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def set_lists
    @list = List.find(params[:id])
  end

  def params_list
    params.require(:list).permit(:name, :url)
  end
end
