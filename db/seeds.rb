require "slugify"

def rand_lat
  i = rand 1..10
  i < 3 ? rand(16.0780597..16.0913458) : rand(16.0554131..16.0752501)
end

def rand_long
  i = rand 1..10
  i < 3 ? rand(108.1114724..108.1462303) : rand(108.1184391..108.2319057)
end

def rand_places_name_prefix
  ["Bệnh viện", "Bệnh Viện Đa Khoa", "Trường Đại Học", "Trường Cao Đẳng"].sample
end

def user_params role: :normal
  address = "#{Faker::Address.street_address}, #{Faker::Address.city}"
  {
    name: Faker::Name.name,
    id_number: Faker::Number.number(9),
    phone_number: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.free_email,
    password: "12345678",
    address: address,
    gender: rand(0..1),
    blood_type: User.blood_types.keys.sample,
    role: role,
    birthday: Faker::Date.between(35.years.ago, 18.years.ago),
    lat: rand_lat,
    lon: rand_long,
    formatted_address: address
  }
end

def create_places
  20.times do
    name = "#{rand_places_name_prefix} #{Faker::Address.city}"
    address = Faker::Address.street_address
    Place.create name: name, address: address, longitude: rand_lat, latitude: rand_long, formatted_address: address
  end
end

def create_users
  200.times do |n|
    role = case true
    when n.between?(1, 3)
      :admin
    when n.between?(4, 10)
      :limited
    else
      :normal
    end
    place = Place.order("RAND()").first
    admin = [User.admin.order("RAND()").first, nil].sample
    is_verified = admin.nil? ? false : true
    i = rand 1..100
    volume = case true
    when i.between?(1, 5)
      :ml_450
    when i.between?(6, 15)
      :ml_350
    else
      :ml_250
    end
    user = User.new user_params(role: role)
    user.skip_confirmation!
    if user.save
      user.histories.create place: place, date: Faker::Date.between(2.years.ago, Date.today),
      admin: admin, is_verified: is_verified, volume: volume
    end
  end
end

def create_events
  Place.all.each do |place|
    title = Faker::Lorem.paragraph 2
    date_time = Faker::Time.between(20.days.ago, 2.months.from_now, :morning)
    content = rand(3..10).times.inject([]) {|list| list << Faker::Lorem.paragraph(rand(3..10))}.join "<br>"
    user_id = User.admin.first.id
    title_slug = Slugify.create(title) << "-" << SecureRandom.hex(3).upcase
    place.events.create! title: title, date_time: date_time, content: content, is_public: true, user_id: user_id, title_slug: title_slug
  end
end

def create_articles
  20.times do
    title = Faker::Lorem.paragraph 2
    user_id = User.admin.first.id
    content = rand(3..15).times.inject([]) {|list| list << Faker::Lorem.paragraph(rand(3..10))}.join("<br>" * rand(1..3))
    title_slug = Slugify.create(title) << "-" << SecureRandom.hex(3).upcase
    created_at = Faker::Time.between(3.months.ago, Time.current, :morning)
    Article.create! title: title, user_id: user_id, content: content, title_slug: title_slug, is_public: true, created_at: created_at
  end
end

puts "***************** Seeding data *******************"
puts "#{Time.current}\tCreating places..."
create_places
puts "#{Time.current}\tCreating users..."
create_users
puts "#{Time.current}\tCreating events..."
create_events
puts "#{Time.current}\tCreating articles..."
create_articles
puts "************** Seeded successfully ***************"
