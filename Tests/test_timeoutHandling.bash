source ../secure_otp_transaction.bash

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
PINK='\033[1;35m'
YELLOW='\033[0;33m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
ORANGE='\033[38;5;214m'
No_Color='\033[0m'

export GREEN RED BLUE PINK YELLOW CYAN WHITE ORANGE No_Color

echo -e "   ${BLUE}[Testing Timeout Handling]${No_Color}\n"
tput civis
for (( i=20; i>0; i-- )); do
    if (( i%2 == 0 )); then
        echo -ne "\r${YELLOW}.${No_Color}"
        sleep 0.05
    else
        echo -ne "\r${YELLOW}_${No_Color}"
        sleep 0.05
    fi
done
echo -ne "\r             "
test_timeout_with_no_input() 
{
    (
        for (( i=5; i>0; i-- )); do
        echo -ne "\rTest 1 : ${CYAN}Timeout Encountered with No User Input ${No_Color}; Should Timeout  in ${YELLOW}$i ${No_Color}s"
        sleep 1
        done
    ) &
    
    # Use a function to provide input
    provide_input() 
    {
        echo "9876543210"  # Phone number
        sleep $((time_set + 4))  # Keep stream open
    }
    
    # Start the script with input from function
    provide_input | bash ./deepseek.bash >/dev/null 2>&1 &
    pid=$!
    
    # Wait for timeout
    sleep $((time_set))
    
    # Check if process terminated
    if kill -0 $pid 2>/dev/null; then
        echo -e "\rTest 1 : ${CYAN}Timeout Encountered With No User Input                 ${No_Color}Status : ${RED}Fail${No_Color}                             "
        kill $pid
        exit 1
    else
        echo -e "\rTest 1 : ${CYAN}Timeout Encountered With No User Input                 ${No_Color}Status : ${GREEN}Pass${No_Color}                             "
    fi
}

test_incomplete_otp_input() 
{
    (
        for (( i=5; i>0; i-- )); do
        echo -ne "\rTest 2 : ${CYAN}Timeout Encountered with Incomplete User Input ${No_Color}; Should Timeout in ${YELLOW}$i ${No_Color}s"
        sleep 1
        done
    ) &
    
    
    # Use a function to provide input
    provide_input() 
    {
        echo "9876543210"  # Phone number
        sleep 1
        echo "123"        # Partial OTP (3 digit here)
        sleep $((time_set + 5))  # Keep stream open
    }
    
    # Start the script with input from function
    provide_input | bash ./deepseek.bash >/dev/null 2>&1 &
    pid=$!
    
    # Wait for timeout
    sleep $((time_set))
    
    # Check if process terminated
    if kill -0 $pid 2>/dev/null; then
        echo -e "\rTest 2 : ${CYAN}Timeout Encountered with Incomplete User Input         ${No_Color}Status : ${RED}Fail${No_Color}"
        kill $pid
        exit 1
    else
        echo -e "\rTest 2 : ${CYAN}Timeout Encountered with Incomplete User Input         ${No_Color}Status : ${GREEN}Pass${No_Color}                  "
    fi
}

# Set shorter timeout for testing
time_set=5

test_timeout_with_no_input
test_incomplete_otp_input