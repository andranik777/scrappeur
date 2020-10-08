require 'nokogiri'
require 'open-uri'
require 'rubygems'


def depute_email(depute_url)
	page = Nokogiri::HTML(URI.open(depute_url)) 
	page.xpath("//*[@id='haut-contenu-page']/article/div[3]/div/dl/dd[4]/ul/li[2]/a").text
end

def depute_urls
	url = []
	page = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")) 
	page.xpath("//*[@id='deputes-list']/div/ul/li/a").each { |m| url.push(m['href'])}
	return url
end

def all_depute_emails
    d_emails = []
    d_url = depute_urls
	d_url.each { |url|
    d_emails << depute_email("http://www2.assemblee-nationale.fr/#{url}")}
	return d_emails
end

def nom_depute
	d_noms = []
	page = Nokogiri::HTML(URI.open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
end

def perform
	arr_d_emails = []
	all_d_emails = all_depute_emails
	
end 

