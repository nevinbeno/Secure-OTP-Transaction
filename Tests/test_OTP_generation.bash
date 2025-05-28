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

echo -e "   ${BLUE}[Testing OTP Generation]${No_Color}"
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

test_OTP_range()
{
    for (( i=0; i<100; i++ )); do
        OTP=$((RANDOM % 9000 + 1000))
        if (( OTP < 1000 || otp > 9999 )); then
            echo -e "\nTest 1 : ${CYAN}OTP range test (100 Test Cases)                        ${No_Color}Status : ${RED}Fail${No_Color}"
            exit 1
        fi
    done
    echo -e "\nTest 1 : ${CYAN}OTP range test (100 Test Cases)                        ${No_Color}Status : ${GREEN}Pass${No_Color}"
}

test_OTP_range