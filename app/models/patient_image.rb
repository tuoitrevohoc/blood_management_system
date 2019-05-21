class PatientImage < Image
  mount_uploader :file, ImageUploader
end
