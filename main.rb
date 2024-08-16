require 'thor'
require 'exifr/jpeg'

class GpsCLI < Thor
  desc 'extract [FILENAME]', 'Extracts and prints info about a file'
  def extract(f) 
    data = EXIFR::JPEG.new(f)
    puts "FileName: #{f}"
    puts 'Skipping file. xif is nil' unless data.exif?
    puts 'Skipping file. Gps is nil.' if data.gps.nil? && data.exif?
    puts "Lat: #{data.gps.latitude} | Long: #{data.gps.longitude}" if data.exif? && !data.gps.nil?
  end

  desc 'extract_dir DIRECTORY', 'Extracts and prints info about all jpg files in a directory'
  def extract_dir(directory = './**/*.jpg')
    directory += '*.jpg' if directory[-1] == '/'

    d = Dir[directory]

    puts "Reading #{d.length} files from #{directory}"

    d.map do |file|
      extract(file) if File.extname(file) == '.jpg'
    end

    puts 'Finished.'

  end

  # recursively read through all folders and files in the given directory, 
  # -- With no parameters, the utility should default to scanning from the current directory. It should take an optional 
  # -- parameter that allows any other directory to be passed in.

  # Dir["/path/to/search/*"]
  # and if you want to find all Ruby files in any folder or sub-folder:
  # Dir["/path/to/search/**/*.jpg"]

  # extracts info from each file: file name, EXIF GPS data (longitude and latitude)

  # writes the name of that image and any GPS co-ordinates it finds to a CSV file
  # -- As a bonus, output either CSV or HTML, based on a parameter passed in via the command line.
end

GpsCLI.start(ARGV)
