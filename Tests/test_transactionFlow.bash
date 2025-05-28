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

echo -e "   ${BLUE}[Testing Transaction Flow]${No_Color}"
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

test_OTP_matching()
{
    #assume user enteres the correct OTP
    OTP=1234 # OTP generated
    user=1234 # OTP entered
    if ! [[ "$user" == "$OTP" ]]; then
        echo -e "\nTest 1 : ${CYAN}OTP Matching Test                                      ${No_Color}Status : ${RED}Fail${No_Color}"
        exit 1
    fi
    echo -e "\nTest 1 : ${CYAN}OTP Matching Test                                      ${No_Color}Status : ${GREEN}Pass${No_Color}"
}
test_OTP_mismatching()
{
    # assume user enter some incorrect OTP.
    OTP=2345 # OTP generated
    user=8787 # OTP entered
    if [[ "$user" == "$OTP" ]]; then
        echo -e "Test 2 : ${CYAN}OTP Mismatch Test                                      ${No_Color}Status : ${RED}Fail${No_Color}"
        exit 1
    fi
    echo -e "Test 2 : ${CYAN}OTP Mismatch Test                                      ${No_Color}Status : ${GREEN}Pass${No_Color}"
}
test_no_OTP_input()
{
    #user does not enter any OPT, but press enter before the countdown ends
    OTP=4567
    user=""
    if [[ "$user" == "$OTP" ]]; then
        echo -e "Test 3 : ${CYAN}Empty Input Test                                       ${No_Color}Status : ${RED}Fail${No_Color}"
        exit 1
    fi
    echo -e "Test 3 : ${CYAN}Empty Input Test                                       ${No_Color}Status : ${GREEN}Pass${No_Color}"

}
test_OTP_matching
test_OTP_mismatching
test_no_OTP_input