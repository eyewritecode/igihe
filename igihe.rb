require 'open-uri'
require 'nokogiri'

category = ARGV.first
base_url = "http://igihe.com/"
articles =[]
article_num =0
trash = Nokogiri::HTML(open("http://igihe.com/#{category}"))

puts "\nHi! i found these articles for you:"
puts "\n############################################\n"

trash.css(".homenews-title a").each do |h|
	puts article_num.to_s+" " +h.text
	article_num +=1
	articles << h.attr("href").to_s
end

print "\nSelect one to check its comments> "
article_number = STDIN.gets.chomp().to_i


while(article_number > articles.length) || articles.empty?
	puts "Sorry we couldn't get that article"
	print "Select another article> "
	article_number = STDIN.gets.chomp().to_i
end

article = Nokogiri::HTML(open("#{base_url}#{articles[article_number]}"))
article.css(".commentaires-section #iframe").each do |comments|
	#go to comments document
	iframe = Nokogiri::HTML(open("#{base_url}#{comments.attr('src')}"))
	iframe.css(".comments-text").each do |posts|
		puts posts.text
	end
end
