Boris Bikes
===========
The Week 3 project simulates the bike-renting system in London with classes for bikes, docking stations, vans, garages, and people. A bike can be broken when a person crashes it, and fixed when a van takes it to the garage.

How to use
----------
Clone the repository:
```shell
$ git clone git@github.com:ch2ch3/boris-bikes.git
```

Open in IRB:
```shell
$ irb
	> require './files'
```

Create new objects as needed, e.g.:
```shell
	> ethel = Person.new # makes a new person
	> old_street = DockingStation.new(bikes: [Bike.new]) # makes a new docking station with a bike inside it
	> ethel.rent_bike_from(old_street)
```