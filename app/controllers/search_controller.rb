class SearchController < ApplicationController
  def search
    if params[:title].present?
      @books = Category.where('title LIKE ?', "%#{params[:title]}%")
    else
      @books = Category.none
    end
  end
end