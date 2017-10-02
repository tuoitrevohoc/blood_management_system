namespace :patient do
  desc "To move all patient data from `histories` to `patients`"

  task move_data: :environment do
    puts "Moving data of patients from `histories` to `patients`..."
    excluding_list = ['bệnh nhân cấp cứu', 'bệnh nhi', 'chua', 'Chưa hiến', 'Chưa Hiến',
      'Nguyễn Văn Chưa Hiến', 'Trần Thị chưa Hiến', 'Tran van chua hien', 'Trần Văn Chưa Hiến',
      'Hiến Nhân Đạo', 'Hiến Tập Trung', 'ko', 'Ngũ Hành Sơn', 'Người bệnh', 'Nguyễn văn ko biết',
      'Phường', 'Ngân Hàng Máu', 'ngan hang mau', 'Ngân hàng máu']
    histories = History.includes(:user).all
    errors = []
    invalid_records = []
    logger = Logger.new "log/patient_move_data.log"
    invalid_history_logger = Logger.new "log/invalid_history.log"
    histories.each do |history|
      patient_name = history.patient_name.try :strip
      if patient_name && !excluding_list.include?(patient_name)
        patient = Patient.find_or_initialize_by name: history.patient_name
        patient.assign_attributes patient_params(history)
        if patient.save(validate: false)
          history.update patient: patient
          print "\e[32m.\e[0m"
        else
          errors << "Cannot move data of history##{history.id}: #{patient.errors.full_messages.join(', ')}"
          invalid_records << history.pretty_inspect
          print "\e[31m.\e[0m"
        end
      else
        invalid_records << history.pretty_inspect
        print "."
      end
    end
    logger.error "#{errors}" if errors.any?
    invalid_history_logger.error "#{invalid_records}" if invalid_records.any?
    puts "\nFinished, got #{errors.count} errors. \nSee more detail at '#{Rails.root}/log/patient_move_data.log'"
  end

  def patient_params history
    desc = history.patient_description + "\n>>> DU LIEU CU."
    {
      name: history.patient_name || ("DU LIEU CU_" + SecureRandom.hex(3)),
      gender: :male,
      blood_type: history.user_blood_type,
      pathological: history.patient_pathological || "KHONG CO DU LIEU",
      phone_number: history.patient_phone_number.presence || "84",
      address: history.patient_address || "CAP NHAT SAU",
      description: desc,
    }
  end
end
