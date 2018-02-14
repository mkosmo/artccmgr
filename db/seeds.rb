# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# VATSIM Ratings
Vatsim::Rating.create([
 { name: 'Observer',      short_name: 'OBS' },
 { name: 'Student 1',     short_name: 'S1'  },
 { name: 'Student 2',     short_name: 'S2'  },
 { name: 'Student 3',     short_name: 'S3'  },
 { name: 'Controller 1',  short_name: 'C1'  },
 { name: 'Controller 2',  short_name: 'C2'  },
 { name: 'Controller 3',  short_name: 'C3'  },
 { name: 'Instructor 1',  short_name: 'I1'  },
 { name: 'Instructor 2',  short_name: 'I2'  },
 { name: 'Instructor 3',  short_name: 'I3'  },
 { name: 'Supervisor',    short_name: 'SUP' },
 { name: 'Administrator', short_name: 'ADM' },
])
