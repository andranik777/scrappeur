require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'pry'


page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
arr_nom_depute = []
nom_depute = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')

nom_depute.map{|m|  arr_nom_depute << m.text}

# on stock le nom et le prenom dans un tableau de hash
prenom =[]
i=0; 
while(i < arr_nom_depute.length ) do 
prenom << arr_nom_depute[i].split[1]
i+=1
end  

nom = []
i=0; 
while(i < arr_nom_depute.length ) do 
nom << arr_nom_depute[i].split[2]
i+=1
end  


def get_email(url)
page = Nokogiri::HTML(URI.open(url))
email = page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a
').text.split
return email
end 

def get_urls
page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
arr_url = []
url = page.xpath('//*[@id="deputes-list"]/div/ul/li/a/@href
')
url.each{|m| lien_str = "http://www2.assemblee-nationale.fr/#{m.text}"
arr_url << lien_str
}
return arr_url


end 

def perform
email = get_urls
email.each{|m| get_email(m)}
return email
pry-byebug

end 

email = []
i=0; 
while(i < arr_nom_depute.length ) do 
email << perform
i+=1
end  
h_arr = []

i= 0
while (i<arr_nom_depute.length) do
h_arr << {"first_name" => prenom[i],
"last_name" => nom[i],
"email" =>email[i]
}
i+=1

end
print h_arr


