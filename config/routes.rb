Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "articles#index"
  
  # invoices
  get "invoices", to: "invoices#index"
end
