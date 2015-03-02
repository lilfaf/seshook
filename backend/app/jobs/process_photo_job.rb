class ProcessPhotoJob < ActiveJob::Base
  queue_as :images

  def perform(photoable, upload)
    photoable.photos.create!(remote_file_url: upload.private_url)
    upload.mark_imported!
  end
end
