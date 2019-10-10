require 'open-uri'
require 'nokogiri'

def hash_builder names, values
  hash = Hash.new

  names.each_with_index do |name_index, value_index|
    hash[name_index] = values[value_index]
  end

  hash
end

def nokogiri_parser
	
	names = []
	values = []

	doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
		doc.xpath('//td[@class="text-left col-symbol"]').each do |node|
			names << node.text
		end
		doc.xpath('//a[@class="price"]').each do |node|
		  	values << node.text
		end

	hash_builder(names,values)
	puts hash_builder(names,values)



end

nokogiri_parser




