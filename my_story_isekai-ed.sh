#!/bin/bash

echo "Welcome to Isekai-ed!"
echo "You are an ordinary person living in the modern world, but everything is about to change..."
echo "One evening, while you're walking home, a strange portal opens before you. Before you can react, you're sucked into it."
echo "BOOM! You have been been transported to a magical world! filled with wonder and danger!"
echo "As you arrive in this new world, you find yourself in a beautiful village surrounded by an enchanted forests and majestic mountains."
 
# Initial choice in the new world
while true; do
    echo "As you walk through the village you seem lost and a kind beautiful person offers to help you navigate this strange village."
    echo "Do you:"
    echo "1) Accept their help and get to know them."
    echo "2) Politely decline and focus on finding a way back home."
    read -p "Choose 1 or 2: " choice1
    
    if [[ "$choice1" == "1" ]]; then
        echo "You accept their help and start spending more time together..."

        # Building a relationship
        while true; do
            echo "As days pass, you embark in an adventure and explore the world with this person, but one day you suddenly begin to develop strong feelings for this person."
            echo "One evening, you find yourself alone with them under a starry sky."
            echo "Do you:"
            echo "1) Confess your feelings and tell them how much they mean to you."
            echo "2) Keep your feelings to yourself, fearing it might ruin your friendship."
            read -p "Choose 1 or 2: " choice2
            
            if [[ "$choice2" == "1" ]]; then
                echo "You gather your courage and confess your feelings..."
	        sleep 2
                echo "To your delight, they feel the same way!"
                echo "You share a romantic moment under the stars, and your bond only grows stronger."
                echo "In time, you decide to stay in this new world together, building a life filled with love and happiness."
                echo " "
		echo "Sometimes, taking a risk and being honest about your feelings can lead to a beautiful things in life. <3"
                break
            elif [[ "$choice2" == "2" ]]; then
                echo "You decide to keep your feelings hidden, afraid of what might happen if you reveal them."
                echo "As time goes on, you drift apart, and the bond you shared slowly fades."
                echo "You eventually leave the village, heartbroken and alone. Wondering what if you had said something"
                echo " "
                echo "Fear of rejection can sometimes lead to missed opportunities for happiness."
                exit 0
            else
                echo "Invalid choice. Please choose 1 or 2."
            fi
        done

        break

    elif [[ "$choice1" == "2" ]]; then
        echo "You decide to focus on finding a way back home..."

        # The path of loneliness
        while true; do
            echo "You devote all your time to searching for a way back and form a party"
  	    echo "You keep it a secret that you belong to another world"
	    echo "Everybody in the party starts bonding, you start to trust them, and one day while celebrating around bonfire you're about to share your secret with them..."
            echo "When a shinning light appears before all of you 'its a portal!' A portal that could return you to your original world."
            echo "Do you:"
            echo "1) Enter the portal immediately, eager to return home."
            echo "2) Hesitate, wondering if you should stay and explore the possibilities in this new world."
            read -p "Choose 1 or 2: " choice3

            if [[ "$choice3" == "1" ]]; then
                echo "You step through the portal and return to your original world!"
                echo "However, you can't shake the feeling that you've left something important behind."
                echo "You spend the rest of your life wondering what could have been if you had stayed."
	        echo " "
                echo "Sometimes, the pursuit of what we think we want can lead to lasting regrets."
                break
            elif [[ "$choice3" == "2" ]]; then
                echo "You decide to stay, realizing that there's more to this world than just a way home."
                echo "You return to the village, It has been so long that you forgot your way around"
                echo "To your surprise, you find the person who offered to help you the first time."
                echo "This time, you decide take their help, they show you around the village"
	        echo "you to get to know them, and after a while decided to you asked them out"
	        echo "and ineventually find love and happiness in this new world."
                echo " "
                echo "Embracing the unknown can lead to unexpected joy and fulfillment."
                break
            else
                echo "Invalid choice. Please choose 1 or 2."
            fi
        done
        
        break
    else
        echo "Invalid choice. Please choose 1 or 2."
    fi
done

echo "Your story has come to an end, but the memories of this adventure will stay with you forever."
echo "Thank you for playing!"
