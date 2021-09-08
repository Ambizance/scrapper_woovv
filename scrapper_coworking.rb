require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require 'csv'


# A partir de l'URL d'un CW, on récupère sous forme de tableau les infos qui nous intéressent

def get_cw_infos_from_url(url_coworking)
    page = Nokogiri::HTML(URI.open(url_coworking))   
    # return page.css('h1.product_title').text
    cw_info_tab = []
    cw_info_tab << page.css('h1.product_title').text # name
    cw_info_tab << page.css('h2 + p')[0].text  # description
    cw_info_tab << url_coworking # URL
    cw_info_tab << page.css('.rh-360-content-area p')[2].text  # adresse complète
    cw_info_tab << page.css('.rh-360-content-area p')[11].text  # tarifs
    cw_info_tab << page.css('.rh-360-content-area p')[9].text  # horaires
    # cw_info_tab << page.css('.rh-360-content-area p')[17].text  # facilities >>> BIZARRE CETTE HISTOIRE
    cw_info_tab << page.css('.rh-360-content-area p a')[0]['href'] # penser à retirer le lien affilié coworking-france par la suite
    return cw_info_tab
end




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

def get_all_cw_infos(page_index_general)
    tab_all_url = []
    CSV.open("db_urls.csv", "wb") do |csv|
        csv << ["CW_name", "CW_description", "CW_url", "address", "pricing", "opening_hours", "website_url"] # ne pas oublier de remettre "city" et "zipcode"
        for i in 1..1
            page = page_index_general + i.to_s
            get_coworking_url(page).each do |url|
                csv << [get_cw_infos_from_url(url)]
            end
        end
    end
end

get_all_cw_infos('https://www.coworking-france.com/coworking/coworking-france/page/')



# puts '*'*100
# print get_cw_infos_from_url('https://www.coworking-france.com/espace-coworking/coworking-digital-village-seine-et-marne/')
# print get_cw_infos_from_url('https://www.coworking-france.com/espace-coworking/coworking-digital-village-seine-et-marne/')
# puts '*'*100





# puts get_coworking_url('https://www.coworking-france.com/coworking/coworking-france/')

# puts get_title_from_url('https://www.coworking-france.com/espace-coworking/coworking-la-cantine-numerique-rennes/')
# return title = page.css('h1.product_title').text.split[1..-1].join(' ')


# puts get_title_from_url(get_coworking_url('https://www.coworking-france.com/coworking/coworking-france/coworking-bretagne/coworking-ille-et-vilaine/')[23])