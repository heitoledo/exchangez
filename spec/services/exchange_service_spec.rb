require 'rails_helper'
require 'json'
require './app/services/exchange_service'

describe ExchangeService do
  let(:source_currency) { 'USD' }
  let(:target_currency) { 'BRL' }
  let(:exchange_value) { 3.45656 }
  let(:api_return) do
    {
      currency:[
        currency: "#{source_currency}/#{target_currency}",
        value: exchange_value,
        date: Time.now,
        type: 'Original'
      ]
    }
  end

  before do
    allow(RestClient).to receive(:get) { OpenStruct.new(body: JSON(api_return)) }
  end

  it '#perform' do
    amount = rand(0..100)
    exchanged_value = amount * exchange_value
    exchange_service_result = ExchangeService.new(source_currency, target_currency, amount).perform

    expect(exchange_service_result).to eq(exchanged_value)
  end
end