require 'open-uri'
require 'nokogiri'


def hash_builder names, values
  hash = Hash.new

  names.each_with_index do |name_index, value_index|
    hash[name_index] = values[value_index]
  end

  hash
end


def get_cities_url(cities_list_url)

	cities_url = []

	doc = Nokogiri::HTML(open(cities_list_url))
	doc.xpath('//a[@class="lientxt"]').each do |value|
		url = value["href"]
		final_url = "http://annuaire-des-mairies.com" + url[1..-1]
		cities_url << final_url
	end

	puts cities_url
	return cities_url
end



def get_cities_names(cities_list)

	cities_names = []

	doc = Nokogiri::HTML(open(cities_list))
	doc.xpath('//a[@class="lientxt"]').each do |value|
		cities_names << value.text
	end

	return cities_names
end



def get_townhall_email(townhall_url)

	email = []

	townhall_url.each do |url|
		doc = Nokogiri::HTML(open(url))
			doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |value|
				puts value.text
				email << value.text
			end
	end

	puts email
	return email
end


def perform

	#Get cities names list
	cities_names = get_cities_names("http://annuaire-des-mairies.com/val-d-oise.html")
	
	#Get Cities Townhall URL list
	cities_url = get_cities_url("http://annuaire-des-mairies.com/val-d-oise.html")
	
	#Get the city townhall email
	cities_email = get_townhall_email(cities_url)
	
	#Build the list
	begin

		#final_list = Hash.new
		#final_list = Hash[*cities_names.zip(cities_email).flatten]
		final_list = hash_builder(cities_names,cities_email)
		#puts final_list
	
	rescue => e
		
		puts "Il y a un petit problème (on a perdu une aile) mais pas de panique on continue ..."
	
	end

	puts final_list

end


perform 


