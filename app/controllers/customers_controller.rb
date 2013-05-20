class CustomersController < ApplicationController
  def index
    @customer = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])

    #Get list of email addrs belongs to the customer
    @email = Email.find_all_by_customer_id(@customer.id)

    #Get all rtuser_ids from rt database
    lst_emails = Array.new
    @email.each do |email|
      lst_emails << email.email
    end
    @rtuser = Rtuser.find_all_by_EmailAddress(lst_emails)

    #Get all rttickets
    lst_rtuser_ids = Array.new
    @rtuser.each do |user|
      lst_rtuser_ids << user.id
    end
    @rttickets = Rtticket.find_all_by_Creator(lst_rtuser_ids, order: "LastUpdated desc")
  end

  def create
    #Create cusotmer, action
    @customer = Customer.new(params[:customer])
    @customer.save

    @email = Email.new
    @email.email = params[:email]
    @email.customer_id = @customer.id
    @email.save

    redirect_to customers_path
  end

  def new
    @customer = Customer.new
  end

  def destroy

  end
end
