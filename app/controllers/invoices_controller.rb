class InvoicesController < ApplicationController
  def index
    from_date = params[:from_date]
    to_date = params[:to_date]
  
    if from_date.present? && to_date.present?
      from_date_parsed = Date.parse(from_date).beginning_of_day rescue nil
      to_date_parsed = Date.parse(to_date).end_of_day rescue nil
  
      if from_date_parsed && to_date_parsed
        cache_key = "invoices/#{from_date}/#{to_date}"
        
        # NOTE: adjust cache expiration time as needed
        invoices = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
          Invoice.where(invoice_date: from_date_parsed..to_date_parsed)
                 .order(:invoice_date)
                 .to_a
        end
  
        render json: invoices, status: :ok
      else
        render json: { error: "Invalid date format" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Both from_date and to_date are required" }, status: :unprocessable_entity
    end
  end
end