require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))

arr_names =[]

page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[2]/div').map {|m| arr_names.push(m.content) }
#//*[@class="sc-1kxikfi-0 fjclfm cmc-table__column-name"]

arr_value = []

page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a').map{|m| arr_value << m.content[1..-1].sub(/[","]/, '').to_f }

arr_result = []

arr_result << Hash[arr_names.zip(arr_value)]
print arr_result
