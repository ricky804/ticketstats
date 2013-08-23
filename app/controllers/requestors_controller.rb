class RequestorsController < ApplicationController
  def index
    @requestors = Requestor.all
  end

  def show
    @requestor = Requestor.find(params[:id])
    @open_tickets = Rtticket.open_tickets(@requestor.rtuser_id)
    @all_created_tickets = Rtticket.all_created_tickets(@requestor.rtuser_id)
    @created_tickets = Rtticket.tickets_created_by_user(@requestor.rtuser_id)
    @total_number_of_created_tickets = Rtticket.total_number_of_created_tickets(@requestor.rtuser_id)
    @created_tickets_chart = line_chart(@created_tickets, "Created Tickets", "blue", "Ticket")
  end

  def create
    @requestor = Requestor.new(params[:requestor])
    @requestor.rtuser_id = Requestor.get_rtuser_id(@requestor.email)
    if @requestor.valid?
      if @requestor.save
        redirect_to customer_path(id: @requestor.customer_id), notice: "Saved Successfully"
      else
        redirect_to customer_path(id: @requestor.customer_id), alert: "Error!"
      end
    else
      redirect_to customer_path(id: @requestor.customer_id), alert: "Error!"
    end
  end

  def new
    @requestor = Requestor.new
  end

  def destroy
    requestor = Requestor.find(params[:id])
    if requestor.destroy
      redirect_to customer_path(id: requestor.customer_id), notice: "Successfully Removed"
    else
      redirect_to customer_path(id: requestor.customer_id), alert: "Error!"
    end
  end

end
