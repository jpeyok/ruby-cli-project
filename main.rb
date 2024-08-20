require 'thor'
require 'exifr/jpeg'

class GpsCLI < Thor
  no_commands do
    def csv_headers
      'FILENAME,EXIF_EXISTS,GPS_EXISTS,LATITUDE,LONGITUDE'
    end

    def extract(f)
      data = EXIFR::JPEG.new(f)
      filename = File.basename(f)
      e = data.exif?
      g = !data.gps.nil?
      lat = data.gps.latitude if e && g
      long = data.gps.longitude if e && g
      "#{filename},#{e},#{g},#{lat},#{long}"
    end 
  end

  desc 'extract_dir DIRECTORY', 'Extracts and prints info about all jpg files in a directory'
  def extract_dir(directory = './**/*.jpg')
    directory += '**/*.jpg' if directory[-1] == '/'
    d = Dir[directory]

    if d.empty?
      puts "No jpg files found in #{directory}"
      return
    end

    puts "Reading #{d.length} files from #{directory} and writing gps data to ./output.csv"
    File.open('output.csv', 'w+') do |f|
      f.puts(csv_headers)
      d.map { |file| f.puts(extract(file)) if File.extname(file) == '.jpg' }
    end

    puts 'Finished. Wrote results to ./output.csv'
  end
end

GpsCLI.start(ARGV)
