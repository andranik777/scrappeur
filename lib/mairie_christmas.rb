require 'rubygems'
require 'nokogiri'  
require 'open-uri'
require 'xpath'


def get_townhall_email(townhall_url)
	page = Nokogiri::HTML(URI.open(townhall_url)) #/méthode d'url qui sera utilisé dans la méthode perform pour automatiser la recherche
	arr_email = []

	email = page.xpath('//*[contains(text(), "@")]').text
	mairie = page.xpath('//*[contains(text(), "Adresse mairie de")]').text.split #/ on divise la string pour récupérer uniquement le nom de la ville

	arr_email.push({mairie[3] => email}) #/ on récupere la position du nom de la ville
	puts arr_email
	return arr_email
end

#on collecte toutes les URLs des villes du Val d'Oise
def get_townhall_urls
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	arr_url = []

	urls = page.xpath('//*[@class="lientxt"]/@href') 

	urls.each { |url| #/ pour chaque URLs récupérées, on indique l'url parent "http://annuaire-des-mairies.com"
		url = "http://annuaire-des-mairies.com" + url.text[1..-1] 
		arr_url.push(url)		
	}
	return arr_url 
end

#3 Synchronisation des noms des villes et des emails des mairies
def perform
	arr_url = get_townhall_urls 
	arr_url.each { |townhall_url| get_townhall_email(townhall_url)}
	#/pour chaque URL d'une ville du Val d'Oise, on associe l'adresse mail de la mairie
end 


perform
