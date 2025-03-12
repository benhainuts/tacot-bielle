# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

ItemByStop.destroy_all
Stop.destroy_all
# PlanItem.destroy.all
Car.destroy_all
User.destroy_all

benoit = User.create(email:"benoit@test.com", password:"benoit1905")
juliette = User.create(email:"juliette@test.com", password:"juliette1905")
sami = User.create(email:"sami@test.com", password:"sami1905")
cedric = User.create(email:"cedric@test.com", password:"cedric1905")

toyota = Car.create(make:"Toyota", model:"Yaris", date_of_first_purchase:"2014-08-04", mileage:"114000", estimated_mileage_per_year:"15000", user: benoit)
citroen = Car.create(make:"Citroen", model:"C4", date_of_first_purchase:"2016-04-14", mileage:"26000", estimated_mileage_per_year:"15000", user: benoit)
