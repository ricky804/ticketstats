class RtticketsController < ApplicationController
  def index
    @rtuser = Rtuser.find_by_EmailAddress(current_user.email)
    @total_tickets_created_by_user = Rtticket.find_all_by_Creator(@rtuser.id, :order => "LastUpdated desc")
    @total_number_of_tickets_created_by_user = @total_tickets_created_by_user.count()
    @total_tickets_created_by_user = @total_tickets_created_by_user.paginate(:page => params[:page], :order => params[:sort] ||= "LastUpdated desc")
  end

  def show

  end
end
