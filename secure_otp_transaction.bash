GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
PINK='\033[1;35m'
YELLOW='\033[0;33m'
No_Color='\033[0m'

tput civis
time_set=30 #can be made as per the user's wish

generate_otp()
{
    tput civis
    echo -ne "\r${YELLOW}Processing..   "
    sleep 0.35
    echo -ne "\rGenerating OTP"
    sleep 0.25
    echo -ne "\rSending ..      ${No_Color}"
    sleep 0.20
    tput cnorm
    echo  -e "\rA 4-digit OTP sent to ${BLUE}+91 ${phone_number}. ${No_Color}It will expire in ${YELLOW}${time_set} ${No_Color}seconds. Please enter it promptly.\n${YELLOW}[The OTP entered won't be visible due to security reasons]${No_Color}"
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
    OTP=$(( RANDOM % 9000 + 1000 )) #generate an OTP which is 4 dight (1000 to 9999)
    echo -e "\r${BLUE}OTP : ${YELLOW}${OTP} ${No_Color}(Simulated)"
    tput cnorm
}

transaction_approval()
{
    echo -ne
    echo -ne "${YELLOW}Processing your Transactions..     "
    sleep 1
    echo -ne "\r${YELLOW}Initializing..                                   "
    sleep 0.25
    echo -ne "\r${YELLOW}Processing Request..                             "
    sleep 0.50
    echo -ne "\r${YELLOW}Authenticating Credentials..                     "
    sleep 0.30
    echo -ne "\r${YELLOW}Verifying Account Details..                      "
    sleep 0.40
    echo -ne "\r${YELLOW}Encrypting Data..                                "
    sleep 0.20
    echo -ne "\r${YELLOW}Contacting Bank Server..                         "
    sleep 0.30
    echo -ne "\r${YELLOW}Syncing with Bank Server..                       "
    sleep 0.47
    echo -ne "\r${YELLOW}Validating Transaction..                         "
    sleep 0.30
    echo -ne "\r${YELLOW}Securing the Transaction..                      "
    sleep 0.20
    echo -ne "\r${YELLOW}Finalizing Payment..                             "
    sleep 0.40
    echo -ne "\r${YELLOW}Executing Payment..                              "
    sleep 1.25
    echo -e "\r                                                            "
    echo -ne "\r${GREEN}Transaction Successful !                   ${No_Color}"
    tput cnorm
}

validate_phone()
{
    [[ "$1" =~ ^[6-9][0-9]{9}$ ]] && return 0 || return 1
}

run_transaction_flow()
{
    echo -e
    echo -ne "Please enter your phone number : "
    tput cnorm
    read phone_number
    echo -e

    while ! validate_phone "$phone_number"; do
        echo "Invalid mobile number. Indian numbers start with 9/8/7/6 and contains 10 digits."
        echo -ne "Please enter a valid phone number : "
        read phone_number
    done

    generate_otp

    (
        for (( i=${time_set}; i>0; i-- )); do
            echo -ne "\rTime Left : ${YELLOW}${i}s${No_Color}  [Enter your OTP here]  "
            sleep 1
        done
        echo -e "\r${PINK}Time Out ! ${YELLOW}No Input Received ; OTP Expired. ${No_Color}           "
        kill -9 $$  # Terminates the entire script
    ) & #subshell work, runs behind the main shell.

    read -n 4 -s user_input_otp
    echo -e

    kill $! 2>/dev/null # to stop the countdown, once the OTP has been input by the user

    if [[ ${user_input_otp} == ${OTP} ]]; then
        tput civis
        echo -ne "\r${BLUE}Processing...${No_Color}"
        sleep 0.5
        echo -ne "\r${BLUE}Verifying OTP${No_Color}"
        sleep 0.45
        echo -ne "\r${BLUE}Authenticating..${No_Color}"
        sleep 0.4
        echo -e "\r                                        "
        echo -e "\r${BLUE}OTP Verified ! ${GREEN}Transaction Approved. ${No_Color}"
        sleep 1
        echo
        transaction_approval
    elif [[ ${user_input_otp} == "" ]]; then
        tput civis
        echo
        echo -e "${YELLOW}No Input Received ; OTP Expired. ${No_Color}"
        tput cnorm
        exit 1
    else
        tput civis
        echo -ne "\r${BLUE}Processing...${No_Color}"
        sleep 0.5
        echo -ne "\r${BLUE}Verifying OTP${No_Color}"
        sleep 0.45
        echo -ne "\r${BLUE}Authenticating..${No_Color}"
        sleep 0.55
        echo -e "\r                                        "
        echo -ne "\r\n${BLUE}Potential OTP Mismatch Detected${No_Color}\n"
        sleep 1.5
        echo -e "\n${BLUE}Invalid OTP ! ${RED}Tansaction Failed. ${No_Color}"
        sleep 0.6
        echo -e "\n${PINK}Potential Fraud Hacking. The Transaction Interface is Freezed for ${YELLOW}20 seconds. ${No_Color}Please Retry Again." #to a new line
        for (( i=20; i>0; i-- )); do
            echo -ne "\rYou will be able to re - attempt the Transactions in ${YELLOW}${i} ${No_Color}seconds."
            sleep 1
        done
        echo -e "\r                                                                                                                                  "
        tput cnorm
        exit 1
    fi
}
#the key !
is_main_script()
{
    [[ "${BASH_SOURCE[0]}" == "${0}" ]]
}

if is_main_script; then
    run_transaction_flow
fi
# END OF SOURCE CODE