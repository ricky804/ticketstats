class FavoritesController < ApplicationController
  def index
    @favorite_tickets = Favorite.find_all_by_user_id(current_user.id)
  end

  def new
    #This variable will be used in new view
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(params[:favorite])
    @favorite.user_id = current_user.id
    @favorite.save
    redirect_to favorites_path
  end

  def destroy
    Favorite.find_by_id(params[:id]).destroy
    redirect_to favorites_path
  end

  def edit

  end

  def update

  end

end
