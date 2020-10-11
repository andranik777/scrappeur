require 'rubygems'
require 'nokogiri'  
require 'open-uri'

def get_townhall_email(townhall_url)
page = Nokogiri::HTML(URI.open(townhall_url))
commune = page.css("body > div > main > section.text-center.well.well-sm > div > div > div > h1").text
email= page.xpath('//*[contains(text(),"@")]').text.split
arr =[]
arr << {commune => email.join(" ")}
return arr
end 

#print get_townhall_email('https://www.annuaire-des-mairies.com/95/avernes.html')
def get_townhall_urls

  page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
    all_url = []

urls = page.xpath('//*[@class="lientxt"]//@href')
urls.each{|m| result = "https://www.annuaire-des-mairies.com#{m.text[1..-1]}"
all_url << result
}
return all_url
end





def perform
  email = get_townhall_urls
  result = []
 email.each{|m| puts get_townhall_email(m) }  
end 


print perform
  
