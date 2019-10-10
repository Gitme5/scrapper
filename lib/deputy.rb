require 'open-uri'
require 'nokogiri'


def get_deputy_names(url)

	deputy_list = []

	doc = Nokogiri::HTML(open(url))
	doc.xpath('//option').each do |value|
		cut = value.text.split(' ')[1..-1]
		deputy_list << cut
	end

	print deputy_list
	puts deputy_list.size
	return deputy_list
end


def get_deputy_url_list(url)

	deputy_url_list = []
	deputy_final_url_list = []

	doc = Nokogiri::HTML(open(url))
	doc.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |value|
		puts value["href"]
		deputy_url_list << value["href"]
	end

	deputy_url_list.each do |url|
		deputy_final_url_list << "http://www2.assemblee-nationale.fr" + url
	end	

	puts deputy_final_url_list
	puts deputy_url_list.size
	return deputy_final_url_list

end


def deputy_email(deputy_email_url)

	email_list = []

	puts "GO EMAIL"
	deputy_email_url.each do |url|
		doc = Nokogiri::HTML(open(url))
		doc.xpath('//dd//a[@class="email"]').each do |value|
			mail_select = value.text.split.select{|word| word.length > 25}
			puts mail_select
			email_list << mail_select
		end
	end

	return email_list

end


begin

	url = get_deputy_url_list("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
	names = get_deputy_names("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
	email = deputy_email(url)

	final_list = Hash.new
	
	names.each do |first_name,last_name|	
		email.each do |mail|
			final_list["Prenom"] = first_name
			final_list["Nom"] = last_name
			final_list["Mail"] = mail
		end
	end

rescue => e

	puts "Pas de panique tout va bien"

end 

print final_list
