require 'open-uri'
require 'nokogiri'

def hash_builder names, values

  result = []
  names.each_with_index do |name_index, index|
  	result << {name_index => values[index]}
  end

  return result

end

def nokogiri_parser
	
	names = []
	values = []

	doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
		doc.xpath('//td[@class="text-left col-symbol"]').each do |node|
			names << node.text
		end
		doc.xpath('//a[@class="price"]').each do |node|
		  	values << node.text.gsub('$','').to_f
		end

	hash_builder(names,values)
	puts hash_builder(names,values)



end

nokogiri_parser




