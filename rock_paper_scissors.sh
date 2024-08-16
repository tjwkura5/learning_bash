options=("Rock", "Paper", "Scissors")

player_score=0

game_score=0

#Get random value in array
get_random() {
    random_index=$((RANDOM % ${options[@]}))

    random_value=${options[$random_index]}

    echo "$random_value"
}

#Play five rounds of rock paper scissor shoot
for i in {1..5}; do
done


select option in "${options[@]}"; do
    case "$option" in 
    "Rock")
    # do stuff here
    ;;

    "Paper")
    # do stuff here
    ;;
    "Scissors")
    # do stuff here
    ;;
    *)
    
    ;;
    esac 
done