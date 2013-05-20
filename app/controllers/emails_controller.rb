class EmailsController < ApplicationController
  def index
    @email = Email.all
  end

  def show
    @email = Email.find(params[:id])
    @rtuser = Rtuser.find_by_EmailAddress(@email.email)
    @rttickets = Rtticket.find_all_by_Creator(@rtuser.id, order: "LastUpdated desc" )

  end

  def create
    @email = Email.new(params[:email])
    @email.save
    redirect_to emails_path
  end

  def new
    @email = Email.new
    @customer = Customer.all
  end

  def destroy

  end

end
