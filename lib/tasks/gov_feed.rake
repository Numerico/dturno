desc "scrap chilean gov.'s web page to obtain drugstores nightly service schedule"
task :gov_feed => :environment do

  url = 'http://datos.gob.cl/datasets/ver/1547'
  regex = /para las farmacias de la/
  tmp = "/tmp/dturno_file.xlsx"
  year = 2013

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

    # TODO limpiar esto y hacer task de normalización
    last_row = nil
    data.each do |row|
      next if row[0].nil? || row[1].nil? || row[2].nil?
      # si hay hoyos, lo más probable que sean entremedio
      row[0] = last_row if row[0].nil?  
      # region
      region_arr = row[0].split "-"
      unless region_arr.nil? || region_arr[0].nil? || region_arr[1].nil? # a veces trae nombre, a veces no
        region = Region.find_or_create_by numero: region_arr[0].strip, nombre: region_arr[1].strip
      else
        region = Region.find_or_create_by numero: row[0].strip
      end
      # comuna
      comuna = Comuna.find_or_create_by nombre: row[1].strip, region_id: region.id
      # date
      begin
        date = Date.new year, row[5].to_i, row[4].to_i
      rescue
        begin
          date = Date.new year, row[6].to_i, row[5].to_i # algunos tienen fono entre medio...
        rescue
          # hay fechas q no existen (31 Septiembre...)
        end
      end
      # instance
      drugs <<  DrugStore.new(name: row[2], address: row[3], day: row[4], month: row[5], time: row[6], comuna_id: comuna.id, date: date)
      #
      last_row = row[0]
    end

    DrugStore.import drugs
    Rails.logger.info "#{DrugStore.count} drugstores total"

  end

end
