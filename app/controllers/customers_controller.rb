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
    @rttickets = Rtticket.find_all_by_Creator(lst_rtuser_ids, order: "LastUpdated desc").paginate(page: params[:page], per_page: 10)
    @number_of_tickets_created = @rttickets.count()
    @counts_created = Rtticket.count(conditions: ["Creator in (?)", lst_rtuser_ids], group: "DATE_FORMAT(Created, '%Y-%m')")
    @counts_closed = Rtticket.count(
      conditions: ["Creator in (?) and Status in (?)", lst_rtuser_ids, lst_closed_ticket],
      group: "DATE_FORMAT(Created, '%Y-%m')"
    )
    @chart = draw_line_chart(@counts_created, @counts_closed)
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
