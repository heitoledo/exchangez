require 'rest_client'
require 'json'

class ExchangeService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount
  end

  def perform
    begin
      get_exchange * @amount.to_f
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  private
  def get_exchange
    api_key = ENV['CURRENCY_API_KEY']
    api_url = ENV['CURRENCY_API_URL']
    url = "#{api_url}?token=#{api_key}&currency=#{@source_currency}/#{@target_currency}"
    res = RestClient.get(url)

    JSON.parse(res.body)['currency'][0]['value'].to_f
  end
end