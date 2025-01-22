class SalesReportMailer < ApplicationMailer
  # NOTE: change the default email as needed
  default from: 'no-reply@example.com'

  def daily_sales_report(user, top_days)
    @user = user
    @top_days = top_days
    mail(to: @user.email, subject: "Daily Top Sales Report")
  end
end