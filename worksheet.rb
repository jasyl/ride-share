########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
# Which layers are nested in each other?
# Which layers of data "have" within it a different layer?
# Which layers are "next" to each other?

########################################################
# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have

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


########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
#
def get_sum(symbol, profile)
    sum = profile.sum { |hash| hash[symbol] }
  return sum
end

def get_average(symbol, profile)
  sum = get_sum(symbol, profile)
  avg = ((sum % profile.length == 0 ? sum : sum.to_f) / profile.length).round(1)
  return avg
end

def collect_info(symbol)
  result = []
  DRIVER.ID.each do |id, profile|
    result << [id,  ]
  end
end
# - the number of rides each driver has given
DRIVER_ID.each do |id, profile|
  puts "#{id} gave #{profile.length} rides"
end

# - the total amount of money each driver has made
save_totals_for_each_driver(:COST).each do |sub_array|
  puts "#{sub_array[0]} made a total of $#{sub_array[1]}"
end

# - the average rating for each driver
DRIVER_ID.each do |id, profile|
  sum = profile.sum {|hash| hash[:RATING]}
  avg = ((sum % profile.length == 0 ? sum : sum.to_f) / profile.length).round(1)
  puts "#{id} has an average rating of #{avg} stars"
end

# - Which driver made the most money?
most_money = save_totals(:COST).max_by do |each_driver|
  each_driver[1]
end
puts "#{most_money[0]} made the most money at $#{most_money[1]}"

# - Which driver has the highest average rating?
highest_rating = save_totals(:RATING).max_by do |each_driver|
  each_driver[1]
end
puts "#{highest_rating[0]} has the highest average rating with #{highest_rating[1]} stars"