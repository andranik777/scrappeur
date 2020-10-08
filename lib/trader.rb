require 'rubocop'
require 'rspec'
require 'nokogiri'
require 'pry'
require 'open-uri'

def trader
  arr_symbols = []
  page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))
  page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div').each {|m|arr_symbols << (m.content)} 
  
  arr_values = []
  
  page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a').each { |m| arr_values << (m.content) }
  
  new_hash = Hash[arr_symbols.zip(arr_values)]
  return new_hash
end
print trader