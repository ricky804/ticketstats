class RtticketsController < ApplicationController
  def index
    @open_tickets = Rtticket.open_tickets(session[:rtuser_id])
    @number_of_open_tickets = @open_tickets.count
    @created_tickets = Rtticket.tickets_created_by_user(session[:rtuser_id])
    @closed_tickets = Rtticket.tickets_closed_by_user(session[:rtuser_id])
    @total_number_of_resolved_tickets = Rtticket.total_number_of_resolved_tickets(session[:rtuser_id])
    @total_number_of_created_tickets = Rtticket.total_number_of_created_tickets(session[:rtuser_id])
    @created_tickets_chart = line_chart(@created_tickets, "Created Tickets", "blue", "Ticket")
    @closed_tickets_chart = line_chart(@closed_tickets, "Closed Tickets", "green", "Ticket")

    #This will be used in the popup
    @favorite = Favorite.new
  end


  def show

  end
end
