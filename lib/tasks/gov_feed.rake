desc "scrap chilean gov.'s web page to obtain drugstores nightly service schedule"
task :gov_feed do
  agent = Mechanize.new
  page = agent.get 'http://datos.gob.cl/datasets/ver/1547'
  links = page.links_with text: /para las farmacias de la/
  links.each do |link|
  	file = agent.get link.href
    GovDoc.create link: link.href, name: file.filename, content: file.content
  end
end
