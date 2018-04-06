json.set! :genders do
  json.set! :labels, t("users.genders").values
  json.set! :values, [
    @male, 100 - @male
  ]
end

# json.set! :genders, [
#   [t("users.genders.male"), @male],
#   [t("users.genders.female"), 100 - @male],
# ]
