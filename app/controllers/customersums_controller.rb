class CustomersumsController < ApplicationController
  def index
    @customers = Customer.all
    @created_tickets_by_customer = Hash.new
    @customers.each do |customer|
      customer.emails.each do |email|
        @rtuser = Rtuser.find_by_EmailAddress(email.email)
        @count_rtticket_created = Rtticket.count(conditions: ["Creator=? and Created >= DATE_SUB(NOW(), INTERVAL 1 MONTH)", @rtuser.id])
        @created_tickets_by_customer[customer.name] = @created_tickets_by_customer[customer.name].to_i + @count_rtticket_created.to_i
      end
    end

    @chart = draw_bar_chart(@created_tickets_by_customer)

  end
end


