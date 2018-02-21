# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create default roles
roles = {}
roles['guest']          = Role.create({ name: "Guest" })
roles['visitpr']        = Role.create({ name: "Visiting Controller" })
roles['home']           = Role.create({ name: "Home Controller" })
roles['mentor']         = Role.create({ name: "Mentor" })
roles['instructor']     = Role.create({ name: "Instructor" })
roles['eventadmin']     = Role.create({ name: "Event Administrator" })
roles['facilityadmin']  = Role.create({ name: "Facility Administrator" })
roles['trainingadmin']  = Role.create({ name: "Training Administrator" })
roles['rosteradmin']    = Role.create({ name: "Roster Administrator" })
roles['superadmin']     = Role.create({ name: "Super Administrator" })

Setting.create( {
                    key: "roles",
                    value: {
                        guest:          roles['guest'].id,
                        visitor:        roles['visitpr'].id,
                        home:           roles['home'].id,
                        mentor:         roles['mentor'].id,
                        instructor:     roles['instructor'].id,
                        eventsadmin:    roles['eventadmin'].id,
                        facilityadmin:  roles['facilityadmin'].id,
                        trainingadmin:  roles['trainingadmin'].id,
                        rosteradmin:    roles['rosteradmin'].id,
                        superadmin:     roles['superadmin'].id
                    }
                } )


# Training Session types
Training::Type.create([
 { name: 'Lecture' },
 { name: 'Live Lesson' },
 { name: 'Monitor' },
 { name: 'OTS' },
 { name: 'Sweatbox' }
])

# VATSIM Ratings
Vatsim::Rating.create([
 { name: 'Observer',            short_name: 'OBS',  vatsim_id: 1  },
 { name: 'Tower Trainee',       short_name: 'S1',   vatsim_id: 2  },
 { name: 'Tower Controller',    short_name: 'S2',   vatsim_id: 3  },
 { name: 'TMA Controller',      short_name: 'S3',   vatsim_id: 4  },
 { name: 'Enroute Controller',  short_name: 'C1',   vatsim_id: 5  },
 { name: 'Controller 2',        short_name: 'C2',   vatsim_id: 6  },
 { name: 'Senior Controller',   short_name: 'C3',   vatsim_id: 7  },
 { name: 'Instructor',          short_name: 'I1',   vatsim_id: 8  },
 { name: 'Instructor 2',        short_name: 'I2',   vatsim_id: 9  },
 { name: 'Senior Instructor',   short_name: 'I3',   vatsim_id: 10 },
 { name: 'Supervisor',          short_name: 'SUP',  vatsim_id: 11 },
 { name: 'Administrator',       short_name: 'ADM',  vatsim_id: 12 },
])
