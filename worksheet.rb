########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
# Layer 1 => Drivers
# Layer 2 => All the trips each driver has taken
# Layer 3 => Each trip info

# Which layers are nested in each other?
# Layer 3, Each trip a driver makes is nested within all the trips that the driver has made
# All the trips that a driver has made is correlated to the driver ID

# Which layers of data "have" within it a different layer?
# Layer 1, Within the Drivers' IDs are all the trips that a driver has made.
# Layer 2, the total trips each driver has made have each individual trip saved within it.

# Which layers are "next" to each other?
# Each Driver ID (key) is next to each other or parallel within the hash.
# Each trip (hash) a specific Driver has made is saved parallel in an array (the value of the Driver_ID)
# Within each trip (hash), COST, RATING, RIDER_ID, and DATE are saved next to each other.


########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have
# Layer 1 => Drivers (hash)
# Layer 2 => All the trips each driver has taken (array)
# Layer 3 => Each trip info (hash)

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

DRIVER_ID = {
  DR0001: [
    {
      DATE: "3rd Feb 2016",
      COST: 10,
      RIDER_ID: "RD0003",
      RATING: 3
    },
    {
      DATE: "3rd Feb 2016",
      COST: 30,
      RIDER_ID: "RD0015",
      RATING: 4
    },
    {
      DATE: "5th Feb 2016",
      COST: 45,
      RIDER_ID: "RD0003",
      RATING: 2
    }
  ],
  DR0002: [
    {
      DATE: "3rd Feb 2016",
      COST: 25,
      RIDER_ID: "RD0073",
      RATING: 5
    },
    {
      DATE: "4th Feb 2016",
      COST: 15,
      RIDER_ID: "RD0013",
      RATING: 1
    },
    {
      DATE: "5th Feb 2016",
      COST: 35,
      RIDER_ID: "RD0066",
      RATING: 3
    }
  ],
  DR0003: [
    {
      DATE: "4th Feb 2016",
      COST: 5,
      RIDER_ID: "RD0066",
      RATING: 5
    },
    {
      DATE: "5th Feb 2016",
      COST: 50,
      RIDER_ID: "RD0003",
      RATING: 2
    }
  ],
  DR0004: [
    {
      DATE: "3rd Feb 2016",
      COST: 5,
      RIDER_ID: "RD0022",
      RATING: 5
    },
    {
      DATE: "4th Feb 2016",
      COST: 10,
      RIDER_ID: "RD0022",
      RATING: 4
    },
    {
      DATE: "5th Feb 2016",
      COST: 20,
      RIDER_ID: "RD0073",
      RATING: 5
    }
  ]
}


###########################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:

### METHODS ###

# sum up values that correspond to a specified key in an array of hashes.
def get_sum(key, array_of_hashes)
  array_of_hashes.sum { |hash| hash[key] }
end

# returns the average value of the numbers that correspond to a key in an array of hashes.
def get_average(key, array_of_hashes)
  length = array_of_hashes.length
  sum = get_sum(key, array_of_hashes)
  avg = ((sum % length == 0 ? sum : sum.to_f) / length).round(1)
  return avg
end

# get date & amount that driver earned the most
# This method won't work if dates aren't chronological per driver
def get_day_of_highest_earnings(trips)
  total_earnings = {}
  trips.each do |trip|
    if total_earnings.has_value?(trip[:DATE])
      total_earnings[:amount] += trip[:COST]
    elsif total_earnings.empty? || trip[:COST] > total_earnings[:amount]
      total_earnings = {date: trip[:DATE], amount: trip[:COST]}
    end
  end
  return total_earnings
end

# prints out the drivers' information
def get_each_drivers_info
  DRIVER_ID.each do |driver, trips|
    rating = get_average(:RATING, trips)
    sum = get_sum(:COST, trips)
    num_of_trips = trips.length
    date_of_highest_earnings = get_day_of_highest_earnings(trips)
    puts "\n#{driver} had #{num_of_trips} trips, earned a total of $#{sum}, and has an average rating of #{rating} stars."
    puts "They earned the most on #{date_of_highest_earnings[:date]} with $#{date_of_highest_earnings[:amount]}."
  end
end

# return the hash with the max value
def get_highest_value(array_of_hash, key)
  return array_of_hash.max_by { |driver_and_rating_hash| driver_and_rating_hash[key] }
end

# prints out the driver who made the most and their earnings
def get_highest_earner
  earnings = DRIVER_ID.map { |driver, trips| {driver: driver, earnings: get_sum(:COST, trips)}}
  highest_earner = get_highest_value(earnings, :earnings)
  puts "\n#{highest_earner[:driver]} earned the most money overall with $#{highest_earner[:earnings]}"
end

# prints out the driver who has the highest average rating
def get_highest_avg_rating
  avg_ratings = DRIVER_ID.map { |driver, trips| {driver: driver, rating: get_average(:RATING, trips)}}
  highest_rated = get_highest_value(avg_ratings, :rating)
  puts "\n#{highest_rated[:driver]} has the highest overall rating at #{highest_rated[:rating]} stars"
end

### RESULTS ###

# - the number of rides each driver has given
# - the total amount of money each driver has made
# - the average rating for each driver
# - For each driver, on which day did they make the most money?
get_each_drivers_info

# - Which driver made the most money?
get_highest_earner

# - Which driver has the highest average rating?
get_highest_avg_rating







