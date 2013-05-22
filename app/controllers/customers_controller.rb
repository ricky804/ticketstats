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
    @number_of_tickets_created = @rttickets.count()
  end

  def create
    @customer = Customer.new(params[:customer])
    @email = @customer.emails.new(email: params[:email])
    @customer.valid?
    if @email.valid?
      if @customer.save
        @email.customer_id = @customer.id
        @email.email = params[:email]
        @email.save
        redirect_to customers_path
      else
        render action: "new"
      end
    else
      render action: "new"
    end
  end

  def new
    @email = Email.new
    @customer = Customer.new
  end

  def destroy
    Customer.find_by_id(params[:id]).destroy
    redirect_to customers_path
  end
end
