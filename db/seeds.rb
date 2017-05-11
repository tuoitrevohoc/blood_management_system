require "slugify"

Place.last(10).each do |place|
  title = Faker::Lorem.paragraph 2
  date_time = Faker::Time.between(20.days.ago, 2.months.from_now, :morning)
  content = rand(3..10).times.inject([]) {|list| list << Faker::Lorem.paragraph(rand(3..10))}.join "<br>"
  user_id = User.first.id
  title_slug = Slugify.create(title) << "-" << SecureRandom.hex(3).upcase
  place.events.create! title: title, date_time: date_time, content: content, is_public: true, user_id: user_id, title_slug: title_slug
end

10.times do
  title = Faker::Lorem.paragraph 2
  user_id = User.first.id
  content = rand(3..10).times.inject([]) {|list| list << Faker::Lorem.paragraph(rand(3..10))}.join("<br>" * rand(1..3))
  title_slug = Slugify.create(title) << "-" << SecureRandom.hex(3).upcase
  created_at = Faker::Time.between(3.months.ago, Time.current, :morning)
  Article.create! title: title, user_id: user_id, content: content, title_slug: title_slug, is_public: true, created_at: created_at
end
