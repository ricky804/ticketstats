class FavoritesController < ApplicationController
  def index
    @favorite_tickets = Favorite.find_all_by_user_id(current_user.id)
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.find_by_ticket_id(params[:ticket_id])
    if !@favorite
      @favorite = Favorite.new
      @favorite.ticket_id = params[:ticket_id]
      @favorite.user_id = current_user.id
      @favorite.save
      redirect_to favorites_path
    end
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
