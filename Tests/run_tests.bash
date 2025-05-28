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

echo -e "=== ${PINK}Starting OTP System Tests${No_Color} ==="
spinner=(". " "\ " "| " "/ " "_ ")

tput civis
for (( i=1; i<36; i++ )); do
    echo -ne "\r${YELLOW}${spinner[i % 5]}${No_Color}"
    sleep 0.20
done
echo -e "\r                                         "


declare -a test_files=("test_PhoneNumberValidation.bash" "test_OTP_generation.bash" "test_transactionFlow.bash" "test_timeoutHandling.bash")
for test_file in "${test_files[@]}"; do
    echo -ne "\n🛠  ${ORANGE}File Being Executed : ${WHITE}$test_file${No_Color}"
    if bash "$test_file"; then
        echo -ne "${RED}Authenticating.."
        sleep 0.25
        echo -ne "\r${RED}Verifying..      "
        sleep 0.50
        echo -ne "\r${RED}Approving Status..      "
        sleep 0.75
        echo -ne "\r                                          "
        echo -e "\r✅${YELLOW} $test_file ${No_Color}: ${GREEN}Pass${No_Color}\n"
    else
        echo -e "\r${YELLOW} $test_file ${No_Color}: ${RED}Failed !${No_Color}"
        exit 1
        tput cnorm
    fi
done
echo -e
echo -e "\n${GREEN}All Tests Passed Successfully 🏆${No_Color}"
tput cnorm