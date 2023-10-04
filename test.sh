#!/usr/bin/env

# chmod +xw test.sh
chmod -R 777 ./

# setup for testing
rm -rf testbed
mkdir testbed

cd ./testbed
# end setup for testing

echo " _    _  __  ____  __  _  _    ___    __    __ "
echo "( \/\/ )(  )(_  _)/ _)( )( )  (   \  /  \  / _)"
echo " \    / /__\  )( ( (_  )__(    ) ) )( () )( (/\\"
echo "  \/\/ (_)(_)(__) \__)(_)(_)  (___/  \__/  \__/"

echo "Welcome to Watch Dog! When your dog gets out, you gotta go find it!"
echo "On a scale of 1-10, how big is your neighborhood?"
echo "(Note: The bigger your neighborhood, the harder it is to find your dog!)"
read difficulty

# Validate the difficulty level
while true; do
  # Check if the input is a number
  if [[ $difficulty =~ ^[0-9]+$ ]]; then
    # Check if the input is within the range 1-10
    if ((difficulty >= 1 && difficulty <= 10)); then
      break  # Exit the loop if the input is valid
    else
      echo "That's no good! Enter a number from 1-10!"
      read difficulty
    fi
  else
    echo "That's no good! Enter a number from 1-10!"
    read difficulty
  fi
done

# based on difficulty (1, 2, 3) determine how many streets to loop from
# this writes dirs for everything - need to limit this

# Check if the script is called with an argument
# if [ $# -ne 1 ]; then
#     echo "Usage: $0 <number_of_iterations>"
#     exit 1
# fi

# Store the argument in a variable
# iterations=$1

# Loop for the specified number of iterations
# for (( i = 1; i <= difficulty; i++ )); do
#   echo "Iteration $i"
# done

# # Read the first 5 lines of the text file and shuffle them randomly
# random_lines=$(head -n 5 "structure.txt" | RANDOM % 10)

# # Create directories based on the shuffled lines
# for line in $random_lines; do
#   directory_name=$(echo "$line" | tr -d '[:space:]')  # Remove spaces from the line
#   mkdir -p "$directory_name"
#   echo "Created directory: $directory_name"
# done

num_neighborhoods=($difficulty + 1)

# Set vars for neighborhood values
all_neighborhoods=()
neighborhoods=()
# while IFS= read -r line && [ ${#neighborhoods[@]} -lt $streets ]; do
while IFS= read -r line; do
  all_neighborhoods+=("$line")
done < "../neighborhoods.txt" # TODO: fix this path

# Randomly pick neighborhoods using Fisher-Yates algorithm
# Define the range (min and max values)
neighborhood_min=1
neighborhood_max=${#all_neighborhoods[@]}

# for ((i = ${#all_neighborhoods[@]} - 1; i > 0; i--)); do
for ((i = $num_neighborhoods + 1; i > 0; i--)); do
  # Generate a random number within the range
  random_number=$((RANDOM % ($neighborhood_max - $neighborhood_min + 1) + $neighborhood_min))

  # echo "RANDOM NUMBER: $random_number"
  # echo "PICKING THIS neighborhood: ${all_neighborhoods[random_number]}"
  neighborhoods[i]="${all_neighborhoods[random_number]}"
done

neighborhoods_length="${#neighborhoods[@]}"
echo "Elements in neighborhoods array: $neighborhoods_length"

neighborhood_directory_array=()

# Create directories based on the shuffled lines
for neighborhood in "${neighborhoods[@]}"; do
  directory_name=$(echo "$neighborhood" | tr -d '[:space:]')  # Remove spaces from the line
  mkdir -m 777 -p "$directory_name"
  neighborhood_directory_array+=("$directory_name")
done

# now, do the same for streets within the neighborhoods

# echo "neighborhood_directory_array: $neighborhood_directory_array"
echo "neighborhood array: ${neighborhoods[@]}"

num_streets=$(($difficulty * 5))

# Set vars for neighborhood values
all_streets=()
streets=()
# while IFS= read -r line && [ ${#streets[@]} -lt $streets ]; do
while IFS= read -r line; do
  all_streets+=("$line")
done < "../streets.txt" # TODO: fix this path

# Randomly pick streets using Fisher-Yates algorithm
# Define the range (min and max values)
street_min=1
street_max=${#all_streets[@]}

for ((i = $num_streets - 1; i > 0; i--)); do
  # Generate a random number within the range
  random_number=$((RANDOM % ($street_max - $street_min + 1) + $street_min))

  # echo "RANDOM NUMBER: $random_number"
  # echo "PICKING THIS neighborhood: ${all_neighborhoods[random_number]}"
  streets[i]="${all_streets[random_number]}"
done

streets_length=${#streets[@]}  # Get the length of the streets array
echo "Elements in streets array: $streets_length"

# Create directories based on the shuffled lines
temp_streets_array=()

# Iterate through the streets array
#     directory_name=$(echo "$street" | tr -d '[:space:]')  # Remove spaces from the line
#     mkdir -p "$directory_name"
#     echo "Created directory: $directory_name"

#     temp_streets_array+=("$street")  # Add the street to the temp_streets_array
# done

# while ${#temp_streets_array[@]} < $streets_length; do
# for streets in ${#streets[@]}; do
for street in "${streets[@]}"; do

  # pick the neighborhood where the street will be located
  # for ((i = $neighborhoods - 1; i > 0; i--)); do
  # Generate a random number within the range

  # dir does not work, random number does
  random_index="$((RANDOM % ($neighborhood_max - $neighborhood_min + 1) + $neighborhood_min))"


  # dir works, random doesn;t
  # random_index=$((RANDOM % ${#neighborhood_directory_array[@]}))

  echo "RANDOM NUMBER: $random_index"
  # echo "PICKING THIS neighborhood: ${all_neighborhoods[random_number]}"
  # echo "random_number is $random_number"
  # nh_name="${neighborhood_directory_array[random_number]}"
  nh_name="${neighborhood_directory_array[random_index]}"
  # echo "neighborhoods is $neighborhoods"
  # echo "nh_name is $nh_name"

  # done
  echo "nh_name is $nh_name"

  directory_name=$(echo "$street" | tr -d '[:space:]')  # Remove spaces from the line
  echo "directory path: $nh_name/$directory_name"
  mkdir -m 777 -p "$nh_name/$directory_name"

  # echo "Streets array before: $temp_streets_array"
  temp_streets_array+=("$street")  # Add the street to the temp_streets_array
  # echo "Streets array after: $temp_streets_array"

  # Check the length of the temp_streets_array
  temp_streets_length=${#temp_streets_array[@]}

  # Print the result
  # echo "Temporary Streets Array: ${temp_streets_array[@]}"
  # echo "Temporary Streets Array Length: $temp_streets_length"
done







# todo

# ask the user for their dog name
# ask the user for their home street name

# generate dog file and put it in a random place

# every X times you cd in a dir, move the dog
# every time the dog is moved, every X times leave a poop behind etc

# if you find the dog, do the 'catch dog' command to catch it

# every X times you try to catch dog, it escapes. maybe time limit?