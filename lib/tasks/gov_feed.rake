desc "scrap chilean gov.'s web page to obtain drugstores nightly service schedule"
task :gov_feed do

  url = 'http://datos.gob.cl/datasets/ver/1547'
  regex = /para las farmacias de la/
  tmp = "/tmp/dturno_file.xlsx"

  agent = Mechanize.new
  page = agent.get url
  links = page.links_with text: regex

  links.each do |link|
  	file = agent.get link.href
    GovDoc.create link: link.href, name: file.filename, content: file.content
  end

  drugs = []
  GovDoc.all.each do |doc|
    File.open(tmp, 'wb'){ |output| output.write doc.content }
    excel = SimpleXlsxReader.open tmp # most , TODO cannot parse stream?
    data = excel.sheets.first.data
    data.each do |row|
      next if row[1].nil? && row[2].nil?
      drugs <<  DrugStore.new(name: row[2], address: row[3], day: row[4], month: row[5], time: row[6])
    end
    DrugStore.import drugs
    puts "GovDoc #{doc.name} done. #{DrugStore.count} drugstores total"
    drugs = []
  end

end