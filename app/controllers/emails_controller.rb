class EmailsController < ApplicationController
  def index
    @email = Email.all
  end

  def show
    @email = Email.find(params[:id])
    @rtuser = Rtuser.find_by_EmailAddress(@email.email)
    @rttickets = Rtticket.find_all_by_Creator(@rtuser.id, order: "LastUpdated desc")
    @ticket_counts_by_year_and_month = Rtticket.count(conditions: ["Creator= ?", @rtuser.id], group: "DATE_FORMAT(Created, '%Y-%m')")
    @chart = Email.new.draw_line_chart(@ticket_counts_by_year_and_month.keys(), @ticket_counts_by_year_and_month.values())
  end


  def create
    @email = Email.new(params[:email])
    if @email.valid?
      if !@email.customer_id.blank?
        if @email.save
          redirect_to emails_path
        else
          render action: "new"
        end
      else
        render action: "new"
      end
    else
      render action: "new"
    end
  end

  def new
    @email = Email.new
  end

  def destroy

  end

end
