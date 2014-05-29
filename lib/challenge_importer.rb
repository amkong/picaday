class ChallengeImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/challenge_seed.csv")
    @filename = filename
  end

  def import
    field_names = ['name', 'date']

    print "Importing challenges from #{@filename}: "
    Challenge.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        data = [data[0], Date.parse(data[1])]
        attribute_hash = Hash[field_names.zip(data)]
        challenge = Challenge.create!(attribute_hash)
        print "."; STDOUT.flush
      end
    end
    puts "\nDONE"
  end

end