class InvoicesController < ApplicationController
  def index
    from_date = params[:from_date]
    to_date = params[:to_date]

    if from_date.present? && to_date.present?
      
      from_date = Date.parse(from_date).beginning_of_day rescue nil
      to_date = Date.parse(to_date).end_of_day rescue nil

      if from_date && to_date
        invoices = Invoice.where(invoice_date: from_date..to_date)
        render json: invoices, status: :ok
      else
        render json: { error: "Invalid date format" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Both from_date and to_date are required" }, status: :unprocessable_entity
    end
  end
end