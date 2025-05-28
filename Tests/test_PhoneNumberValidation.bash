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

echo -e "${BLUE}   [Testing Phone Number Validation]${No_Color}"
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
echo -e "\r             "

test_valid_numbers()
{
    valid=("9876543213" "7890123456" "6123456789" "7123456789")
    for number in "${valid[@]}"; do
        if ! [[ $number =~ ^[6-9][0-9]{9}$ ]]; then
            echo -e "Test 1 : ${CYAN}Valid Phone Number Test                                ${No_Color}Status : ${RED}Fail${No_Color}"
            exit 1
        fi
    done
    echo -e "Test 1 : ${CYAN}Valid Phone Number Test                                ${No_Color}Status : ${GREEN}Pass${No_Color}"
}

test_invalid_numbers()
{
    invalid=("543219" "0987654321" "3456765459")
    for number in "${invalid[@]}"; do
        if [[ $number =~ ^[6-9][0-9]{9}$ ]]; then
            echo -e "Test 2 : ${CYAN}Invalid Phone Number Test                              ${No_Color}Status : ${RED}Fail${No_Color}"
            exit 1
        fi
    done
    echo -e "Test 2 : ${CYAN}Invalid Phone Number Test                              ${No_Color}Status : ${GREEN}Pass${No_Color}"
}

test_valid_numbers
test_invalid_numbers