import random
import sys

def play_game():
    # --- DEBUG MODE SETUP ---
    # Checks if "--debug" was typed when starting the script
    DEBUG_MODE = "--debug" in sys.argv 
    
    print("\n" + "="*30)
    print("   HIGHER OR LOWER GAME")
    if DEBUG_MODE: print("   [DEBUG MODE ACTIVE]")
    print("="*30)

    # 1. Level Selection
    print("\nSelect your difficulty:")
    print("1. Easy (1-50)")
    print("2. Normal (1-100)")
    print("3. Hard (1-200)")

    choice = input("Enter 1, 2, or 3: ")
    if choice == "1":
        max_num, level_name = 50, "Easy"
    elif choice == "3":
        max_num, level_name = 200, "Hard"
    else:
        max_num, level_name = 100, "Normal"

    secret_number = random.randint(1, max_num)
    
    # --- DEBUG REVEAL ---
    if DEBUG_MODE:
        print(f"\033[93m[DEBUG] The secret number is: {secret_number}\033[0m")

    guess = 0
    attempts = 0
    previous_guesses = [] 

    print(f"\n--- {level_name} Mode Activated! Range: 1 to {max_num} ---")

    while guess != secret_number:
        user_input = input(f"\nEnter guess #{attempts + 1}: ")
        
        try:
            guess = int(user_input)
            
            if guess in previous_guesses:
                repeat_count = previous_guesses.count(guess)
                if repeat_count >= 2:
                    print(f"!!! Seriously? You've already tried {guess} {repeat_count} times.")
                else:
                    print(f"!! Error: You already guessed {guess}.")
                previous_guesses.append(guess)
                continue 
                
            attempts += 1
            
            # --- DEBUG TRACKING ---
            if DEBUG_MODE:
                print(f"[DEBUG] Distance from target: {abs(secret_number - guess)}")

            if attempts == 2 and guess != secret_number:
                hint = "even" if secret_number % 2 == 0 else "odd"
                print(f"-> HINT: The secret number is {hint}!")

            if len(previous_guesses) > 0 and guess != secret_number:
                valid_history = [g for g in previous_guesses if g != guess]
                if valid_history:
                    current_dist = abs(secret_number - guess)
                    prev_dist = abs(secret_number - valid_history[-1])
                    if current_dist < prev_dist:
                        print("🔥 Warmer!")
                    elif current_dist > prev_dist:
                        print("❄️ Colder!")

            previous_guesses.append(guess)
            
            if guess < secret_number:
                print("Too low!")
            elif guess > secret_number:
                print("Too high!")
            else:
                print(f"🎉 You got it! It took you {attempts} attempts.")
                return attempts
                
        except ValueError:
            print("!! Error: Letters are not allowed.")

if __name__ == "__main__":
    total_attempts = play_game()
    sys.exit(total_attempts)