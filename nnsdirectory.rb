require 'watir'
browser = Watir::Browser.new
# @hreff = 'http://www.nnsdirectory.com/index.php?option=com_vendors&catid=37&Itemid=102'
@hreff = 'http://www.nnsdirectory.com/index.php?option=com_vendors&catid=4&Itemid=59'
browser.goto @hreff
open('numbers.csv', "w") { |f| f << 'First Name,Mobile No.
' } 
@count = 1

browser.table(:id, 'vendorsCatListSymbols').links.each do |linkk|
	@hreff = linkk.href
	browser.execute_script('window.open("'+@hreff.to_s+'")')
	window = browser.window(:title, 'Avtar Enclave - Avtar Enclave')
	loop do
		window.goto @hreff
		window.spans(:class, 'vendorsListing_field_mobile').each do |row|
			if row.text[12] != '.'
				open('numbers.csv', "a") { |f| f << @count.to_s+','+row.text[12..21]+'
' } 
			@count = @count+1
			end
		end
		
		if window.link(:text, 'Next').present?
			@hreff = window.link(:text, 'Next').href
		else
			# browser.window(:title, POPUPWINDOW).close
			window.close
			break
		end		
	end
end	