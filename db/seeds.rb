user = User.new(
  first_name: 'first_name',
  last_name: 'last_name',
  email: 'user@example.com',
  phone: '12345687',
  address: 'IT park',
  city: 'Indore',
  state: 'MP',
  zip: '452001',
  country: 'IN',
  password: '12345678',
  password_confirmation: '12345678'
)

user.save

Product.find_or_create_by(name: "Iphone", description: "2edfrewfdew", price: 25.5)

public_path = Rails.root.join('public')

golmaal = Movie.by_name_and_director("golmaal", 'Hrishikesh Mukherjee').where(release_date: Date.parse("20 April 1979")).first_or_create
sholay = Movie.by_name_and_director("sholay", 'ramesh sippi').where(release_date: Date.parse("15 august 1973")).first_or_create

AttachmentWorker.perform_async(golmaal.id, "#{public_path}/golmaal.jpg")
AttachmentWorker.perform_async(sholay.id, "#{public_path}/sholay.jpg")
