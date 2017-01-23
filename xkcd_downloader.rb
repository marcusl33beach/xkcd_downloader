# Add needed gems
require 'nokogiri'
require 'open-uri'

# Delete old images
class Xkcd
  def self.delete_files()
    # Maybe loop here over file names.
    system('rm *.png')
    system('rm *.jpg')
    system('rm *.pdf')
  end

  # Download new image to be used
  def self.download_png (url)
    url = url
    doc = Nokogiri::HTML(open(url))
    doc.traverse do |el|
      [el[:src], el[:href]].grep(/\.(gif|jpg|png|pdf)$/i).map{ |l| URI.join(url, l).to_s }.each do |link|
          File.open(File.basename(link),'wb'){ |f| f << open(link,'rb').read }
        end
    end
    # Some cleanup
    # Maybe a loop here
    File.delete('a899e84.jpg')
    File.delete('terrible_small_logo.png')
  end
end

# Run run run
Xkcd.delete_files
Xkcd.download_png('http://c.xkcd.com/random/comic/')

# Open the file wirh imgcat
system('imgcat *.png')
