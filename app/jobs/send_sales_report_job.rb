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

    puts "Los 10 días que más ventas tuvieron al día de hoy son:"
    top_days.each_with_index do |(date, total_sales), index|
      puts "#{index + 1}. #{date.strftime('%A, %d de %B de %Y')} - Ventas: $#{'%.2f' % total_sales}"
    end
  end
end