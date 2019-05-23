class PatientImage < Image
  mount_uploader :file, PhotoUploader
end
