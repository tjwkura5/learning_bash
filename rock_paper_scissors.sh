options=("Rock", "Paper", "Scissors")

player_score=0

game_score=0

#Get random value in array
get_random() {
    random_index=$((RANDOM % ${options[@]}))
    random_value=${options[$random_index]}
    echo "$random_value"
}

echo "Welcome to Rock, Paper, Scissors, Shoot!"

#Play five rounds of rock paper scissor shoot
for i in {1..5}; do
    echo "Round $i:"
    computer_choice=$(get_random)
    echo "Please Choose your option:"

    select option in "${options[@]}"; do
        case "$option" in 
        "Rock")
            # do stuff here
            echo "You chose Rock, Computer chose $computer_choice."
            if [ "$computer_choice" == "Paper" ]; then
                echo "Computer wins this round!"
                game_score=$((game_score + 1))
            elif [ "$computer_choice" == "Scissors" ]; then
                echo "You win this round!"
                player_score=$((player_score + 1))
            else
                echo "It's a tie!"
            fi
            break
            ;;

        "Paper")
            # do stuff here
            echo "You chose Paper, Computer chose $computer_choice."
            if [ "$computer_choice" == "Scissors" ]; then
                echo "Computer wins this round!"
                game_score=$((game_score + 1))
            elif [ "$computer_choice" == "Rock" ]; then
                echo "You win this round!"
                player_score=$((player_score + 1))
            else
                echo "It's a tie!"
            fi
            break
            ;;

        "Scissors")
            # do stuff here
            echo "You chose Scissors, Computer chose $computer_choice."
            if [ "$computer_choice" == "Rock" ]; then
                echo "Computer wins this round!"
                game_score=$((game_score + 1))
            elif [ "$computer_choice" == "Paper" ]; then
                echo "You win this round!"
                player_score=$((player_score + 1))
            else
                echo "It's a tie!"
            fi
            break
            ;;

        *)
            echo "Invalid option. Please choose again."
            ;;
        esac 
    done

    echo "Current Score: Player $player_score - Computer $game_score"
    echo "---------------------------------"
done

# Display final result
if [[ "$player_score" -gt "$game_score" ]]; then
    echo "Congratulations! You won the game!"
elif [[ "$player_score" -lt "$game_score" ]]; then
    echo "Sorry, the computer won the game."
else
    echo "It's a tie!"
fi