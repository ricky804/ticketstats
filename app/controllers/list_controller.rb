class ListController < ApplicationController

  #This will access the database to get list of tickets user created.
  def tickets
    #@total_number_of_tickets = Rtticket.count()
    @rtuser = Rtuser.find_by_EmailAddress(current_user.email)
    @total_tickets_created_by_user = Rtticket.find_all_by_Creator(@rtuser.id, :order => "LastUpdated desc")
    @total_number_of_tickets_created_by_user = @total_tickets_created_by_user.count()
    @total_tickets_created_by_user = @total_tickets_created_by_user.paginate(:page => params[:page], :order => params[:sort] ||= "LastUpdated desc")


    #get user email address
    #access the database #
    #
    #run query
    #
    #
    #and get the data


  end

end
