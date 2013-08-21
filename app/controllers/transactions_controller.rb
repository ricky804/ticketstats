class TransactionsController < ApplicationController
  def index
    @activities = Transaction.activities(session[:rtuser_id])
    @comment = Transaction.monthly_activities(session[:rtuser_id], "Comment")
    @respond = Transaction.monthly_activities(session[:rtuser_id], "Correspond")
    @combined_chart = combined_chart(@comment, "Comment", @respond, "Correspond", "Activities for past 1 year")
  end
end
