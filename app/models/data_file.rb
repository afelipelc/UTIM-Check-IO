class DataFile < ActiveRecord::Base
  def self.save(upload, idDev)
    #name =  upload['datafile'].original_filename
    name = idDev + ".jpg"
    directory = "public/userpics"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload.tempfile.read) }
  end
end