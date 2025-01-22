class SalesReportMailerPreview < ActionMailer::Preview
  def daily_sales_report
    top_days = [
      [Date.new(2022, 1, 10), 10000.0],
      [Date.new(2022, 1, 18), 7500.0]
    ]
    user = OpenStruct.new(name: "John Doe", email: "john.doe@example.com")
    SalesReportMailer.daily_sales_report(user, top_days)
  end
end