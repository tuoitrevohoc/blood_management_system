json.set! :genders do
  json.set! :labels, t("users.genders").values
  json.set! :values, [
    @male, 100 - @male
  ]
end
