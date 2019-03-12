require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)
    get '/api/v1/merchants.json'

    expect(response).to be_successful

    merchants = response.body

    expect(merchants.count).to eq(3)
    expect(merchants.first).to have_key("id")
  end

  # find an id with the date in spec harness, and expect it to come out to as the spec harness expects
  # when you use a finder, search for the date format from the spec harness

  # finders use strong params
  # case insensitive searches: column type in postgres called ci text (instead of text)
  # add the above to it.
end
