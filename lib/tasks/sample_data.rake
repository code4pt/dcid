namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Create admin user
    admin = User.create!(name: "Admin User",
                         email: "admin@dcid.org",
                         password: "dcidadmin",
                         password_confirmation: "dcidadmin",
                         citizen_number: "90909999",
                         admin: true)

    # Create base user
    User.create!(name: "Dummy User",
                 email: "example@railstutorial.org",
                 password: "secret",
                 password_confirmation: "secret",
                 citizen_number: "12349999")

    # Create another 99 copies
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "secret"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   citizen_number: "1337000#{n+1}")
    end

    # Create 50 proposals for the first 6 users
    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.sentence(1)
      problem = Faker::Lorem.sentence(4)
      solution = Faker::Lorem.sentence(8)
      upvotes = rand(100)
      downvotes = rand(100)
      users.each { |user| user.proposals.create!(title: title, problem: problem, solution: solution,
                                                  upvotes: upvotes, downvotes: downvotes) }
    end
  end
end
