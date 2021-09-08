require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'csv'


# Fonction qui récupère la liste d'URL d'une page d'index donnée 

def get_coworking_url(page_liste_24_results)
    page = Nokogiri::HTML(URI.open(page_liste_24_results))   
    link_coworking = page.css('h3 a')
    url_tab = []
    link_coworking.each do |lien|
        # url_tab << lien['href']
        url_tab << lien['href']
    end
    return url_tab
    
end


# Fonction qui parcourt chaque page de l'index (105 pages et applique la fonction 
# get_coworking_url sur chacune d'entre elle et stocke toutes les URLs dans un tableau

def get_all_coworking_url(page_index_general)
    tab_all_url = []
    CSV.open("db_urls.csv", "wb") do |csv|
        csv << ["url_coworking"]
        for i in 1..105
            page = page_index_general + i.to_s
            get_coworking_url(page).each do |url|
                csv << [url]
            end
        end
    end
end

get_all_coworking_url('https://www.coworking-france.com/coworking/coworking-france/page/')



def get_title_from_url(url_coworking)
    page = Nokogiri::HTML(URI.open(url_coworking))   
    return page.css('h1.product_title').text
end

# puts get_coworking_url('https://www.coworking-france.com/coworking/coworking-france/')

# puts get_title_from_url('https://www.coworking-france.com/espace-coworking/coworking-la-cantine-numerique-rennes/')
# return title = page.css('h1.product_title').text.split[1..-1].join(' ')


# puts get_title_from_url(get_coworking_url('https://www.coworking-france.com/coworking/coworking-france/coworking-bretagne/coworking-ille-et-vilaine/')[23])