class RtticketsController < ApplicationController
  def index
    @total_tickets_created_by_user = Rtticket.find_all_by_Creator(session[:rtuser_id], :order => "LastUpdated desc")
    @total_number_of_tickets_created_by_user = @total_tickets_created_by_user.count()
    @total_tickets_created_by_user = @total_tickets_created_by_user.paginate(:page => params[:page], :order => params[:sort] ||= "LastUpdated desc")

    #This will be used in the popup
    @favorite = Favorite.new
  end

  def show

  end
end
