require "test_helper"

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test "api returns invoices within the date range provided" do
    
    # Case 1: Both fixtures are returned within the range
    params = {
      from_date: "2022-01-10",
      to_date: "2022-01-18"
    }

    get "/invoices", params: params, xhr: true
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 2, response.length

    # Case 2: One fixture is returned because the other is before the range
    params = {
      from_date: "2022-01-15",
      to_date: "2022-01-18"
    }

    get "/invoices", params: params, xhr: true
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 1, response.length
    assert_equal "C30482", response.first["invoice_number"]

    # Case 3: One fixture is returned because the other is after the range
    params = {
      from_date: "2022-01-10",
      to_date: "2022-01-17"
    }
    
    get "/invoices", params: params, xhr: true
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 1, response.length
    assert_equal "C30481", response.first["invoice_number"]
  end
end