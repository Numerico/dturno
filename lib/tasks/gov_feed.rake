desc "scrap chilean gov.'s web page to obtain drugstores nightly service schedule"
task :gov_feed => :environment do

  url = 'http://datos.gob.cl/datasets/ver/1547'
  regex = /para las farmacias de la/
  tmp = "/tmp/dturno_file.xlsx"

  agent = Mechanize.new
  page = agent.get url
  links = page.links_with text: regex

  links.each do |link|
  	file = agent.get link.href
    GovDoc.create! link: link.href, name: file.filename, content: file.content
    Rails.logger.info "downloaded #{link.href}"
  end

  drugs = []
  GovDoc.find_each(batch_size: 1) do |doc|
    next if doc.name.match /Maule/ # TODO VII.Reg. doc broken
    Rails.logger.info "GovDoc #{doc.name}"
    File.open(tmp, 'wb'){ |output| output.write doc.content }
    excel = SimpleXlsxReader.open tmp # most expensive, TODO cannot parse stream?
    data = excel.sheets.first.data
    data.each do |row|
      next if row[1].nil? && row[2].nil?
      drugs <<  DrugStore.new(name: row[2], address: row[3], day: row[4], month: row[5], time: row[6])
    end
    DrugStore.import drugs
    Rails.logger.info "#{DrugStore.count} drugstores total"
    drugs = []
  end

end
