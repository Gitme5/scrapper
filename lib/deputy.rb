require 'open-uri'
require 'nokogiri'


def get_deputy_list(url)

	deputy_list = []

	doc = Nokogiri::HTML(open(url))
	doc.xpath('//option').each do |value|
		puts value
		puts value.text
		cut = value.text.split.delete(0) # Supprimer le premier élément
		deputy_list << value.text
	end

	puts deputy_list.size
end


def get_deputy_url_list(url)

	deputy_url_list = []

	doc = Nokogiri::HTML(open(url))
	doc.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |value|
		puts value["href"]
		deputy_url_list << value["href"]
	end

	#/html/body/table/tbody/tr[612]/td[2]/span[1]/span[2]
	#/html/body/table/tbody/tr[1407]/td[2]/span[1]/a
	#/html/body/table/tbody/tr[1018]/td[2]/span[1]/span[2]
	#/html/body/table/tbody/tr[1685]/td[2]/span[1]/a
	#//*[@id="deputes-list"]/div[2]/ul[1]/li[20]/a

	deputy_url_list.each do |url|
		url = "http://www2.assemblee-nationale.fr" + url + ".html"
	#	deputy_url_list << url
	end	

	puts deputy_url_list
	puts deputy_url_list.size


end


# //*[@id="mw-content-text"]/div/table[2]/tbody/tr[1]/td[2]/a


get_deputy_url_list("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
#get_deputy_list("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
#get_deputy_list("https://fr.wikipedia.org/wiki/Liste_des_d%C3%A9put%C3%A9s_de_la_XVe_l%C3%A9gislature_de_la_Cinqui%C3%A8me_R%C3%A9publique")

=begin 

deputy_hash
deputy_id[:first] = "Jean"
deputy_id[:name] = "Durant"
deputy_id[:email] = "jean.durant@assemblée.fr"

a << deputy_hash
a = [
  { 
    "first_name" => "Jean",
    "last_name" => "Durant",
    "email" => "jean.durant@assemblée.fr"
  },
  { 
    "first_name" => "Martin",
    "last_name" => "Dupont",
    "email" => "martin.dupont@assemblée.fr"
  },
  etc
]

=end