#!/usr/bin/env

# chmod -R 777 ./

#### reset game
rm -rf neighborhood
mkdir neighborhood

cd ./neighborhood
#### end reset game

#### title
echo " _    _  __  ____  __  _  _    ___    __    __ "
echo "( \/\/ )(  )(_  _)/ _)( )( )  (   \  /  \  / _)"
echo " \    / /__\  )( ( (_  )__(    ) ) )( () )( (/\\"
echo "  \/\/ (_)(_)(__) \__)(_)(_)  (___/  \__/  \__/"

#### end title

#### intro prompt
echo "Welcome to Watch Dog! When your dog gets out, you gotta go find it!"
echo "On a scale of 1-10, how big is your neighborhood?"
echo "(Note: The bigger your neighborhood, the harder it is to find your dog!)"
read difficulty
#### end intro prompt

# Need input timestamps so we can tell when the dog gets bored and keeps going
# TODO
# last_input_timestamp=$(date +%s)

#### Validate the difficulty level
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
#### end validate the difficulty level

echo "What's your dog's name?"
read dog_name

# Check if the input contains any digits
if [[ "$dog_name" =~ ^[0-9]+$ ]]; then
  echo "That's a bunch of numbers! I'm asking for your dog's name, not its phone number!"
fi

# debug
# echo "dog name is $dog_name"

num_neighborhoods=($difficulty + 1)

# Use for tracking all possible directories
all_street_directories=()

# Set vars for neighborhood values
all_neighborhoods=()
neighborhoods=()
# while IFS= read -r line && [ ${#neighborhoods[@]} -lt $streets ]; do
while IFS= read -r line; do
  all_neighborhoods+=("$line")
done < "../lib/neighborhoods.txt" # TODO: fix this path

# Randomly pick neighborhoods
neighborhood_min=1
neighborhood_max=${#all_neighborhoods[@]}

for ((i = $num_neighborhoods + 1; i > 0; i--)); do
  random_number=$((RANDOM % ($neighborhood_max - $neighborhood_min + 1) + $neighborhood_min))

  neighborhoods[i]="${all_neighborhoods[random_number]}"
done

neighborhoods_length="${#neighborhoods[@]}"
# debug echo "Elements in neighborhoods array: $neighborhoods_length"

neighborhood_directory_array=()

# Create directories based on the shuffled lines
for neighborhood in "${neighborhoods[@]}"; do
  directory_name=$(echo "$neighborhood" | tr -d '[:space:]')  # Remove spaces from the line
  mkdir -m 777 -p "$directory_name"
  neighborhood_directory_array+=("$directory_name")
done

# now, do the same for streets within the neighborhoods

# debug
# echo "neighborhood array: ${neighborhoods[@]}"

num_streets=$(($difficulty * 5))

# Set vars for neighborhood values
all_streets=()
streets=()
while IFS= read -r line; do
  all_streets+=("$line")
done < "../lib/streets.txt"

# Randomly pick streets
street_min=1
street_max=${#all_streets[@]}

for ((i = $num_streets - 1; i > 0; i--)); do
  random_number=$((RANDOM % ($street_max - $street_min + 1) + $street_min))

  streets[i]="${all_streets[random_number]}"
done

streets_length=${#streets[@]}  # Get the length of the streets array

# Create directories based on the shuffled lines
for street in "${streets[@]}"; do
  random_index=$((RANDOM % ${#neighborhood_directory_array[@]}))
  nh_name="${neighborhood_directory_array[random_index]}"

  directory_name=$(echo "$street" | tr -d '[:space:]')  # Remove spaces from the line
  mkdir -m 777 -p "$nh_name/$directory_name"

  all_street_directories+=("$nh_name/$directory_name")
done

# debug for all dir generation
# echo "All street dirs:"
# for element in "${all_street_directories[@]}"; do
#   echo "Element: $element"
# done

dog_file_extension=".dog"
dog_file_name=$dog_name$dog_file_extension

# debug for dog filename
# echo "Dog filename: $dog_file_name"

# place the dog somewhere
random_street_directory_index=$((RANDOM % ${#neighborhood_directory_array[@]}))

random_directory="${all_street_directories[random_street_directory_index]}"

# dogs have opinions
dog_opinions=(
    'bark grrr wuf!'
    '<big lick>'
    'baooooooooo!'
    'barf warf'
    'booooooooka boark'
    'blurf yarf!'
    'woofus barko'
    'meep meep <3'
    '<emits unreasonably stinky fart>'
    '<makes full eye contact and yawns>'
    'ooeuf!'
    '<lip smacking noises>'
    '<sits patiently>'
    'whimper woooo'
    'hhhhhhhhr'
    'yyyyyarf'
    'buchh'
    'myuaaaaang'
    'myroaar'
    'boof.'
  )

random_dog_opinion_index=$((RANDOM % ${#dog_opinions[@]}))
random_dog_opinion="${dog_opinions[random_dog_opinion_index]}"

# debug to enter spoiler mode
# echo "Made a dog in $random_directory"
echo $random_dog_opinion > $dog_file_name
mv $dog_file_name $random_directory/$dog_file_name

# debug for opinions
# echo "random dog opinion: $random_dog_opinion"

# TODO: Fix up how to get multiple dogs in there

# dog_one=
# cat <<"ONE"
#     ___
#  __/_  `.  .-"""-.
#  \_,` | \-'  /   )`-')
#   "") `"`    \  ((`"`
#  ___Y  ,    .'7 /|
# (_,___/...-` (_/_/
# ONE

# dog_two=
# cat <<"TWO"
#     /^ ^\
#    / 0 0 \
#    V\ Y /V
#     / - \
#    /    |
#   V__) ||
# TWO

# dog_three=
# cat <<"THREE"
#      _____^_
#      |    |    \
#       \   /  ^ |
#      / \_/   0  \
#     /            \
#    /    ____      0
#   /      /  \___ _/
# THREE

# echo '
#      |\_/|
#      | @ @   Woof!
#      |   <>              _
#      |  _/\------____ ((| |))
#      |               `--' |
#  ____|_       ___|   |___.'
# /_/_____/____/_______|
# '

# dog_five=cat << "FIVE"
#           /  \
#          / ..|\
#         (_\  |_)
#         /  \@'
#        /     \
#    _  /  `   |
#   \\/  \  | _\
#    \   /_ || \\_
#     \____)|_) \_)
# FIVE

# dog_pics=(
#   $dog_one
#   $dog_two
#   $dog_three
#   $dog_four
#   $dog_five
# )

# random_dog_pic_index=$((RANDOM % ${#dog_pics[@]}))

# # echo "random_dog_pic_index: $random_dog_pic_index"
# random_dog_pic="${dog_pics[random_dog_pic_index]}"

echo "<<<<<<<<<<<<<<<<<<<<<<<<"
# echo ${dog_pics[random_dog_pic_index]}
cat << "EOF"
     ___
  __/_  `.  .-"""-.
  \_,` | \-'  /   )`-')
   "") `"`    \  ((`"`
  ___Y  ,    .'7 /|
 (_,___/...-` (_/_/
EOF
echo ">>>>>>>>>>>>>>>>>>>>>>>>"
echo "Your dog's on the loose!"
echo "Use the 'ls' command to see nearby neighborhoods and streets!"
echo "Use the 'cd' command to change directories and track down that pup!"
echo "Try 'cd/neighborhood' to start looking!"

