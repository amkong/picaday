class ImageImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/image_seed.csv")
    @filename = filename
  end

  def import
    field_names = ['title', 'url']

    print "Importing images from #{@filename}: "
    Image.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        image = Image.create!(attribute_hash)
        print "."; STDOUT.flush
      end
    end
    puts "\nDONE"
  end

end