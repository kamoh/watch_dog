#!/usr/bin/env

echo "Welcome to Watch Dog! When your dog gets out, you gotta go find it!"
echo "On a scale of 1-10, how big is your neighborhood?"
echo "(Note: The bigger your neighborhood, the harder it is to find your dog!)"
read difficulty
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
for (( i = 1; i <= difficulty; i++ )); do
  echo "Iteration $i"
done

# # Read the first 5 lines of the text file and shuffle them randomly
# random_lines=$(head -n 5 "structure.txt" | RANDOM % 10)

# # Create directories based on the shuffled lines
# for line in $random_lines; do
#   directory_name=$(echo "$line" | tr -d '[:space:]')  # Remove spaces from the line
#   mkdir -p "$directory_name"
#   echo "Created directory: $directory_name"
# done

streets=$(($difficulty * 5))

# Read the first 5 lines of the text file into an array
lines=()
while IFS= read -r line && [ ${#lines[@]} -lt $streets ]; do
  lines+=("$line")
done < "structure.txt"

# Shuffle the lines randomly using Fisher-Yates algorithm
for ((i = ${#lines[@]} - 1; i > 0; i--)); do
  j=$((RANDOM % (i + 1)))
  temp="${lines[i]}"
  lines[i]="${lines[j]}"
  lines[j]="$temp"
done

# Create directories based on the shuffled lines
for line in "${lines[@]}"; do
  directory_name=$(echo "$line" | tr -d '[:space:]')  # Remove spaces from the line
  mkdir -p "$directory_name"
  echo "Created directory: $directory_name"
done


# sed '/^$/d;s/ /\//g' structure.txt | xargs mkdir -p

# ask the user for their dog name
# ask the user for their home street name

# generate dog file and put it in a random place

# every X times you cd in a dir, move the dog
# every time the dog is moved, every X times leave a poop behind etc

# if you find the dog, do the 'catch dog' command to catch it

# every X times you try to catch dog, it escapes. maybe time limit?