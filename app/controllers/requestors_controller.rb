class RequestorsController < ApplicationController
  def index
    @requestors = Requestor.all
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
