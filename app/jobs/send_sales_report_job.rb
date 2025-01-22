class SendSalesReportJob < ApplicationJob
  queue_as :default

  # Get the top 10 days with the most sales
  # 
  def perform
    top_days = Invoice
                .group("DATE(invoice_date)")
                .order("SUM(total) DESC")
                .limit(10)
                .pluck("DATE(invoice_date) AS day, SUM(total) AS total")

    # NOTE: change the user name and email as needed (or change to use dynamically)
    user = OpenStruct.new(name: "Carlos Salinas", email: "csalinas@contalink.com")
    SalesReportMailer.daily_sales_report(user, top_days).deliver_now

    puts "Se ha enviado el reporte de ventas al correo #{user.email}"
  end
end