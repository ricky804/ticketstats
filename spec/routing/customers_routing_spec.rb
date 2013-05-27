require 'spec_helper'

describe "routing to list of customers" do
  it "routes /customers:index to customer#index for customer" do 
    expect(get: "/customers").to route_to(controller: "customers", action: "index")
  end
end
