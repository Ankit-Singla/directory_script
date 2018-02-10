require 'watir'
browser = Watir::Browser.new
# @hreff = 'http://www.nnsdirectory.com/index.php?option=com_vendors&catid=37&Itemid=102'
@hreff = 'http://www.nnsdirectory.com/index.php?option=com_vendors&catid=4&Itemid=59'
browser.goto @hreff
open('numbers.csv', "w") { |f| f << 'First Name,Mobile No.
' } 
@count = 1

# STDOUT.puts browser.table(:id, 'vendorsCatListSymbols')

browser.table(:id, 'vendorsCatListSymbols').links.each do |linkk|

	@hreff = linkk.href
	@browser2 = Watir::Browser.new :chrome
	@browser2.goto @hreff
	loop do
		@browser2.goto @hreff
		@browser2.spans(:class, 'vendorsListing_field_mobile').each do |row|
			if row.text[12] != '.'
				open('numbers.csv', "a") { |f| f << @count.to_s+','+row.text[12..21]+'
' } 
			@count = @count+1
			end
		end
		
		if @browser2.link(:text, 'Next').present?
			@hreff = @browser2.link(:text, 'Next').href
		else
			@browser2.close
			break
		end		
	end
end	