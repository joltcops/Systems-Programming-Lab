# Function to display a single digit in 5x5 pattern
display_digit() {
    digit=$1
    i=$2
    if [ $i -eq 0 ]; then 
        case $digit in
            0) echo -n "  ---  ";;
            1) echo -n "     . ";;
            2) echo -n "  ---  ";;
            3) echo -n "  ---  ";;
            4) echo -n " .   . ";;
            5) echo -n "  ---  ";;
            6) echo -n "  ---  ";;
            7) echo -n "  ---  ";;
            8) echo -n "  ---  ";;
            9) echo -n "  ---  ";;
        esac
    elif [ $i -eq 1 ]; then 
        case $digit in
            0) echo -e -n " |   | ";;
            1) echo -e -n "     | ";;
            2) echo -e -n "     | ";;
            3) echo -e -n "     | ";;
            4) echo -e -n " |   | ";;
            5) echo -e -n " |     ";;
            6) echo -e -n " |     ";;
            7) echo -e -n "     | ";;
            8) echo -e -n " |   | ";;
            9) echo -e -n " |   | ";;
        esac
    elif [ $i -eq 2 ]; then 
        case $digit in
            0) echo -n " |   | ";;
            1) echo -n "     | ";;
            2) echo -n "  ---  ";;
            3) echo -n "  ---  ";;
            4) echo -n "  ---| ";;
            5) echo -n "  ---  ";;
            6) echo -n "  ---  ";;
            7) echo -n "     | ";;
            8) echo -n "  ---  ";;
            9) echo -n "  ---  ";;
        esac
    elif [ $i -eq 3 ]; then 
        case $digit in
            0) echo -n " |   | ";;
            1) echo -n "     | ";;
            2) echo -n " |     ";;
            3) echo -n "     | ";;
            4) echo -n "     | ";;
            5) echo -n "     | ";;
            6) echo -n " |   | ";;
            7) echo -n "     | ";;
            8) echo -n " |   | ";;
            9) echo -n "     | ";;
        esac
    elif [ $i -eq 4 ]; then 
        case $digit in
            0) echo -n "  ---  ";;
            1) echo -n "     . ";;
            2) echo -n "  ---  ";;
            3) echo -n "  ---  ";;
            4) echo -n "     . ";;
            5) echo -n "  ---  ";;
            6) echo -n "  ---  ";;
            7) echo -n "     . ";;
            8) echo -n "  ---  ";;
            9) echo -n "  ---  ";;
        esac
    fi
}

# Function to print the colon
display_colon() {
    i=$1
    s=$2
    if [ $((10#$s%2)) -eq 0 ]
    then
        if [ $i -eq 0 ]; then 
            echo -n "       "
        elif [ $i -eq 1 ]; then 
            echo -n "   o   "
        elif [ $i -eq 2 ]; then 
            echo -n "       "
        elif [ $i -eq 3 ]; then 
            echo -n "   o   "
        elif [ $i -eq 4 ]; then 
            echo -n "       "
        fi
    else
        if [ $i -eq 0 ]; then 
            echo -n "       "
        elif [ $i -eq 1 ]; then 
            echo -n "       "
        elif [ $i -eq 2 ]; then 
            echo -n "       "
        elif [ $i -eq 3 ]; then 
            echo -n "       "
        elif [ $i -eq 4 ]; then 
            echo -n "       "
        fi
    fi
}

# Loop forever
while true; do
    clear

    # Get terminal dimensions
    terminal_height=$(tput lines)
    terminal_width=$(tput cols)

    # Calculate the number of empty lines needed for vertical centering
    clock_height=8  # Height of the clock (including spaces)
    num_empty_lines=$(( (terminal_height - clock_height) / 2 ))

    # Print empty lines for top alignment
    for ((line=1; line<=num_empty_lines; line++)); do
        echo
    done

    # Calculate the number of spaces needed for horizontal centering
    clock_width=64  # Width of the clock (including spaces and text)
    num_spaces=$(( (terminal_width - clock_width) / 2 ))

    # Get current date and time
    datetime=$(date +"%A %d %B %Y %I %M %S %p %Z")

    # Extract different fields
    read -r day date month year hour minute second ampm timezone <<< $datetime

    # Print the date as a string
    printf "%${num_spaces}s%s %s %s\n" " " "$day" "$date" "$month $year"
    printf "%${num_spaces}s%s %s %s\n" " " "+--------------------------------------------------------------+"
    for ((i=0; i<5; i++))do
        printf "%${num_spaces}s" " "
        echo -n "|  " 
        for ((j=0; j<${#hour}; j++)); do
            display_digit "${hour:$j:1}" "$i"
        done 
        display_colon "$i" "$second"
        for ((j=0; j<${#minute}; j++)); do
            display_digit "${minute:$j:1}" "$i"
        done
        display_colon "$i" "$second"
        for ((j=0; j<${#second}; j++)); do
            display_digit "${second:$j:1}" "$i"
        done
        if [ $i != 4 ]; then 
            echo "    |"
        fi
    done

    echo "$ampm  |"
    printf "%${num_spaces}s%s %s %s\n" " " "+--------------------------------------------------------------+"

    # Print empty lines for bottom alignment
    remaining_lines=$((terminal_height - num_empty_lines - clock_height))
    for ((line=1; line<=remaining_lines; line++)); do
        echo
    done

    # Wait for the user to hit return
    read -t 0.5 -r && break
done
