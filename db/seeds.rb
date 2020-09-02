# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
doctors = [
  {
    firstname: 'Edward',
    lastname: 'Armstrong',
    email: 'edward.armstrong@anklearrival.com',
    city: 'NY',
    username: 'edward_armstrong'
  },
   {
    firstname: 'Charles',
    lastname: 'Burton',
    email: 'charles.burton@anklearrival.com',
    city: 'KOR',
    username: 'charles_burton'
  },
   {
    firstname: 'Mark',
    lastname: 'Hall',
    email: 'mark.hall@anklearrival.com',
    city: 'CA',
    username: 'mark_hall'
  },
   {
    firstname: 'Peter',
    lastname: 'Leavitt',
    email: 'peter.leavitt@anklearrival.com',
    city: 'TX',
    username: 'peter_leavitt'
  },
  {
    firstname: 'Jeremy',
    lastname: 'Stone',
    email: 'jeremy.stone@anklearrival.com',
    city: 'FCT',
    username: 'jeremy_stone'
  },
   {
    firstname: 'Yuri',
    lastname: 'Zhivago',
    email: 'yuri.zhivago@anklearrival.com',
    city: 'RUS',
    username: 'yuri_zhivago'
  },
  {
    firstname: 'Ramón',
    lastname: 'Madera',
    email: 'ramon.madera@anklearrival.com',
    city: 'COL',
    username: 'ramon_madera'
  },
  {
    firstname: 'Franz',
    lastname: 'Edlemann',
    email: 'franz.edlemann@anklearrival.com',
    city: 'FRA',
    username: 'franz_edlemann'
  },
  {
    firstname: 'Stephanie',
    lastname: 'Brody',
    email: 'stephanie.brody@anklearrival.com',
    city: 'BAC',
    username: 'stephanie_brody'
  },
  {
    firstname: 'Christine',
    lastname: 'Chapel',
    email: 'christine.chapel@anklearrival.com',
    city: 'NJ',
    username: 'christine_chapel'
  }
]

doctors.each do |doctor|
  Doctor.create(doctor)
end