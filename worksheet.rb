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

# prints out the name of the driver and the number of rides they gave
def get_num_of_rides
  DRIVER_ID.each do |driver, trips|
    puts "#{driver} gave #{trips.length} rides"
  end
end

# prints out the driver and total amount each driver made
def get_total_earnings
  DRIVER_ID.each do |driver, trips|
    sum = get_sum(:COST, trips)
    puts "#{driver} earned a total of $#{sum}"
  end
end

# prints out the driver and their avg rating
def get_avg_rating
  DRIVER_ID.each do |driver, trips|
    avg = get_average(:RATING, trips)
    puts "#{driver} has an average rating of #{avg} stars"
  end
end

# prints out the driver who made the most and their earnings
def get_highest_earner
  earnings = DRIVER_ID.map { |driver, trips| {driver: driver, sum: get_sum(:COST, trips)}}
  highest_earner = earnings.max_by { |driver_and_sum_hash| driver_and_sum_hash[:sum] }
  puts "#{highest_earner[:driver]} earned the most money with $#{highest_earner[:sum]}"
end

# prints out the driver who has the highest average rating
def get_highest_avg_rating
  avg_ratings = DRIVER_ID.map { |driver, trips| {driver: driver, rating: get_average(:RATING, trips)}}
  highest_rated = avg_ratings.max_by { |driver_and_rating_hash| driver_and_rating_hash[:rating] }
  puts "#{highest_rated[:driver]} has the highest rating at #{highest_rated[:rating]} stars"
end

### RESULTS ###

# - the number of rides each driver has given
get_num_of_rides
puts

# - the total amount of money each driver has made
get_total_earnings
puts

# - the average rating for each driver
get_avg_rating
puts

# - Which driver made the most money?
get_highest_earner
puts

# - Which driver has the highest average rating?
get_highest_avg_rating

# - For each driver, on which day did they make the most money?
DRIVER_ID.each do |driver, trips|
  total_earnings = {}
  trips.each do |trip|
    if total_earnings.key?(trip[:DATE])
      total_earnings[:amount] += trip[:COST]
    elsif total_earnings.empty? || trip[:COST] > total_earnings[:amount]
      total_earnings = {date: trip[:DATE], amount: trip[:COST]}
    end
  end
  puts "#{driver} earned the most on #{total_earnings[:date]} with $#{total_earnings[:amount]}"
end



