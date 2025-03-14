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
PlanItem.destroy_all
Car.destroy_all
User.destroy_all

benoit = User.create(email:"benoit@test.com", password:"benoit1905")
juliette = User.create(email:"juliette@test.com", password:"juliette1905")
sami = User.create(email:"sami@test.com", password:"sami1905")
cedric = User.create(email:"cedric@test.com", password:"cedric1905")

toyota = Car.create(make:"TOYOTA", model:"Yaris", date_of_first_purchase:"2002-08-04", mileage:148000, estimated_mileage_per_year:15000, fuel: "Essence", engine: "1.5", last_follow_up_km:130000, last_follow_up_date:"2024-09-12",  horsepower: 105, user: benoit)
file = File.open(Rails.root.join("app", "assets", "images", "cars_seed", "toyota.jpg"))
toyota.photo.attach(io: file, filename: "toyota.png", content_type: "image/png")
toyota.save

# citroen = Car.create(make:"CITROEN", model:"C4", date_of_first_purchase:"2016-04-14", mileage:85000, estimated_mileage_per_year:15000, fuel: "Essence", engine: "1.2", last_follow_up_km:83000, last_follow_up_date:"2024-12-05",  horsepower: 130, user: benoit)
# file = File.open(Rails.root.join("app", "assets", "images", "cars_seed", "citroen.jpg"))
# # citroen.photo.attach(io: file, filename: "citroen.png", content_type: "image/png")
# # citroen.save



toyota_vidange_d_huile_moteur = PlanItem.create(name: "Vidange d'huile moteur", to_do_every_x_km: 10000, to_do_every_x_years: 1, car: toyota )
toyota_remplacement_du_filtre_a_huile = PlanItem.create(name: "Remplacement du filtre à huile", to_do_every_x_km: 15000, to_do_every_x_years: 1, car: toyota )
toyota_remplacement_du_filtre_a_air = PlanItem.create(name: "Remplacement du filtre à air", to_do_every_x_km: 30000, to_do_every_x_years: 2, car: toyota )
toyota_remplacement_du_filtre_a_carburant = PlanItem.create(name: "Remplacement du filtre à carburant", to_do_every_x_km: 60000, to_do_every_x_years: 4, car: toyota )
toyota_remplacement_du_filtre_d_habitacle = PlanItem.create(name: "Remplacement du filtre d'habitacle", to_do_every_x_km: 30000, to_do_every_x_years: 2, car: toyota )
toyota_remplacement_de_la_courroie_de_distribution = PlanItem.create(name: "Remplacement de la courroie de distribution", to_do_every_x_km: 140000,to_do_every_x_years: 6, car: toyota )
toyota_purge_et_remplacement_du_liquide_de_frein = PlanItem.create(name: "Purge et remplacement du liquide de frein", to_do_every_x_km: 80000, to_do_every_x_years: 2, car: toyota )
toyota_remplacement_du_liquide_de_refroidissement = PlanItem.create(name: "Remplacement du liquide de refroidissement", to_do_every_x_km: 90000, to_do_every_x_years: 6, car: toyota )
toyota_changement_de_pneus = PlanItem.create(name: "Changement de pneus", to_do_every_x_km: 80000, to_do_every_x_years: 6, car: toyota )
# citroen_vidange_d_huile_moteur = PlanItem.create(name: "Vidange d'huile moteur", to_do_every_x_km: 10000, to_do_every_x_years: 1, car: citroen )
# citroen_remplacement_du_filtre_a_huile = PlanItem.create(name: "Remplacement du filtre à huile", to_do_every_x_km: 15000, to_do_every_x_years: 1, car: citroen )
# citroen_remplacement_du_filtre_a_air = PlanItem.create(name: "Remplacement du filtre à air", to_do_every_x_km: 30000, to_do_every_x_years: 2, car: citroen )
# citroen_remplacement_du_filtre_a_carburant = PlanItem.create(name: "Remplacement du filtre à carburant", to_do_every_x_km: 60000, to_do_every_x_years: 4, car: citroen )
# citroen_remplacement_du_filtre_d_habitacle = PlanItem.create(name: "Remplacement du filtre d'habitacle", to_do_every_x_km: 30000, to_do_every_x_years: 2, car: citroen )
# citroen_remplacement_de_la_courroie_de_distribution = PlanItem.create(name: "Remplacement de la courroie de distribution", to_do_every_x_km: 100000,to_do_every_x_years: 6, car: citroen )
# citroen_purge_et_remplacement_du_liquide_de_frein = PlanItem.create(name: "Purge et remplacement du liquide de frein", to_do_every_x_km: 60000, to_do_every_x_years: 2, car: citroen )
# citroen_remplacement_du_liquide_de_refroidissement = PlanItem.create(name: "Remplacement du liquide de refroidissement", to_do_every_x_km: 90000, to_do_every_x_years: 6, car: citroen )

stop_yaris_1 = Stop.create(date:"2022-04-05", garage:"Toyota St Quentin", cost:300, mileage:107560, car: toyota)
stop_yaris_2 = Stop.create(date:"2023-03-30", garage:"Toyota St Quentin", cost:350, mileage:120000, car: toyota)
stop_yaris_3 = Stop.create(date:"2024-04-15", garage:"Norauto", cost:600, mileage:130000, car: toyota)
# t.float "cost"
# t.integer "mileage"

item_stop_yaris_1_toyota_vidange_d_huile_moteur = ItemByStop.create(stop: stop_yaris_1, plan_item:toyota_vidange_d_huile_moteur,item_cost:150, deadline_date_for_this_item:"2022-05-05", deadline_km_for_this_item:116000, calculated_next_date_milestone:"2023-05-05", calculated_next_km_milestone:117560)
item_stop_yaris_1_toyota_remplacement_du_filtre_a_huile = ItemByStop.create(stop: stop_yaris_1, plan_item:toyota_remplacement_du_filtre_a_huile, item_cost:50, deadline_date_for_this_item:"2022-05-05", deadline_km_for_this_item:116000, calculated_next_date_milestone:"2023-05-05", calculated_next_km_milestone:122560)
item_stop_yaris_2_toyota_vidange_d_huile_moteur = ItemByStop.create(stop: stop_yaris_2, plan_item:toyota_vidange_d_huile_moteur, item_cost:170, deadline_date_for_this_item:"2023-05-05", deadline_km_for_this_item:122560, calculated_next_date_milestone:"2024-03-30", calculated_next_km_milestone:130000)
item_stop_yaris_2_toyota_remplacement_du_filtre_a_huile = ItemByStop.create(stop: stop_yaris_2, plan_item:toyota_remplacement_du_filtre_a_huile, item_cost:70, deadline_date_for_this_item:"2023-05-05", deadline_km_for_this_item:122560, calculated_next_date_milestone:"2024-03-30", calculated_next_km_milestone:135000)
item_stop_yaris_3_toyota_vidange_d_huile_moteur = ItemByStop.create(stop: stop_yaris_3, plan_item:toyota_vidange_d_huile_moteur, item_cost:170, deadline_date_for_this_item:"2024-03-30", deadline_km_for_this_item:130000, calculated_next_date_milestone:"2024-04-15", calculated_next_km_milestone:140000)
item_stop_yaris_3_toyota_remplacement_du_filtre_a_huile = ItemByStop.create(stop: stop_yaris_3, plan_item:toyota_remplacement_du_filtre_a_huile, item_cost:80, deadline_date_for_this_item:"2024-03-30", deadline_km_for_this_item:135000, calculated_next_date_milestone:"2024-04-15",calculated_next_km_milestone:145000)
item_stop_yaris_3_toyota_toyota_changement_de_pneus  = ItemByStop.create(stop: stop_yaris_3, plan_item:toyota_changement_de_pneus, item_cost:370, deadline_date_for_this_item:"2021-05-30", deadline_km_for_this_item:120000, calculated_next_date_milestone:"2030-04-15", calculated_next_km_milestone:210000)

# t.bigint "stop_id", null: false
# t.bigint "plan_item_id", null: false
# t.float "item_cost"
# t.integer "deadline_km_for_this_item"
# t.integer "calculated_next_km_milestone"
# t.date "deadline_date_for_this_item"
# t.date "calculated_next_date_milestone"
# item_cost:370, deadline_date_for_this_item:"2021-05-30", deadline_km_for_this_item:120000, calculated_next_date_milestone:"2030-04-15",calculated_next_km_milestone:200000
