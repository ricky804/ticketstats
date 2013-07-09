class EmailsController < ApplicationController
  def index
    @email = Email.all
  end

  def show
    @email = Email.find(params[:id])
    @rtuser = Rtuser.find_by_EmailAddress(@email.email)
    @rttickets = Rtticket.find_all_by_Creator(@rtuser.id, order: "LastUpdated desc").paginate(page: params[:page], per_page: 10)
    @counts_created = Rtticket.count(conditions: ["Creator= ?", @rtuser.id], group: "DATE_FORMAT(Created, '%Y-%m')")
    @counts_closed = Rtticket.count(
      conditions: ["Creator=? and Status in (?)", @rtuser.id, lst_closed_ticket],
      group: "DATE_FORMAT(Created, '%Y-%m')"
    )
    @chart = draw_line_chart(@counts_created, @counts_closed)

    @counts_resolved_by_email = Transaction.count(conditions: ["NewValue = 'resolved' and Creator = ?", @rtuser.id], group: "DATE_FORMAT(Created, '%Y-%m')")
    @chart2 = draw_simple_line_chart(@counts_resolved_by_email)
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
    Email.find_by_id(params[:id]).destroy
    redirect_to emails_path
  end

end
