require 'rubygems'
require 'nokogiri' 
require 'open-uri'


starting_url = Nokogiri::HTML(URI.open("https://www.coworking-france.com/coworking/coworking-france/coworking-bretagne/coworking-ille-et-vilaine/"))   

# puts link_coworking

def get_coworking_url(page_list)
    page = Nokogiri::HTML(URI.open(page_list))   
    link_coworking = page.css('h3 a')
    url_tab = []
    link_coworking.each do |lien|
        # url_tab << lien['href']
        url_tab << lien['href']
    end


     return url_tab

end

def get_title_from_url(url_coworking)
    page = Nokogiri::HTML(URI.open(url_coworking))   
    return page.css('h1.product_title').text

end

# puts get_coworking_url('https://www.coworking-france.com/coworking/coworking-france/coworking-bretagne/coworking-ille-et-vilaine/')

# puts get_title_from_url('https://www.coworking-france.com/espace-coworking/coworking-la-cantine-numerique-rennes/')
# return title = page.css('h1.product_title').text.split[1..-1].join(' ')


puts get_title_from_url(get_coworking_url('https://www.coworking-france.com/coworking/coworking-france/coworking-bretagne/coworking-ille-et-vilaine/')[23])