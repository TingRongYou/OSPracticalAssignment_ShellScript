#! /bin/bash

main_menu() {
    clear
    echo "Patron Maintenance Menu"
    echo
    echo "A - Add New Patron Details"
    echo "S - Search A Patron (by Patron ID)"
    echo "U - Update a Patron Details"
    echo "D - Delete a Patron Details"
    echo "L - Sort Patrons by Last Name"
    echo "P - Sort Parons by Patron ID"
    echo "J - Sort Patrons by Joined Date (Newest to Oldest Date)"
    echo
    echo "Q - Exit from Program"

    is_valid_choice=true

    while $is_valid_choice; 
    do
        echo
        read -p 'Please Select A Choice: ' menu_choice
        case ${menu_choice^^} in 
        "A")
        is_valid_choice=false
        add_patron_form
        ;;
        "S")
        is_valid_choice=false
        search_patron_by_id
        ;;
        "U")
        is_valid_choice=false
        #Update
        ;;
        "D")
        is_valid_choice=false
        #Delete
        ;;
        "L")
        is_valid_choice=false
        #Sort(LastName)
        ;;
        "P")
        is_valid_choice=false
        #Sort(PatronID)
        ;;
        "J")
        is_valid_choice=false
        #Sort(Date)
        ;;
        "Q")
        is_valid_choice=false
        exit 0
        ;;
        *)
        echo ">>> Please enter valid choice (A, S, U, D, L, P, J, Q)!"
        ;;
        esac
    done
}

add_patron_form() {
    clear
    echo "Add New Patron Form"
    echo "===================="
    echo "Patron ID: "
    echo "First Name: "
    echo "Last Name: "
    echo "Mobile Number: "
    echo "Birth Date (MM-DD-YYYY): "
    echo "Membership type (Student / Public): "
    echo "Joined Date (MM-DD-YYYY): "
    echo
    echo "Press (q) to return to Patron Maintenance Menu."

    add_new_patron
}

add_new_patron() {

    is_valid_choice=true

    while $is_valid_choice; 
    do 
        echo
        read -p 'Add another new patron details? (y)es or (q)uit: ' add_patron_choice
        case ${add_patron_choice^^} in 
        "Y")
        is_valid_choice=false
        clear
        echo "Add New Patron Form"
        echo "===================="

        is_valid_patron_id=true

        while $is_valid_patron_id; 
        do
            read -p 'Patron ID (Pxxxx): ' patron_id
            if [ ${#patron_id} -eq 5 ] && [[ $patron_id =~ ^P[0-9]{4}$ ]] && [[ -n $patron_id ]]
            then 
                is_valid_patron_id=false
                break
            else 
                echo "Please enter patron id in format (Pxxx)" 
                echo 
            fi
        done

        is_valid_first_name=true

        while $is_valid_first_name;
        do
            read -p 'First Name: ' first_name
            if [ ${#first_name} -lt 30 ] && [[ -n $first_name ]] && [[ $first_name == [a-z] || [A-Z] ]]
            then 
                is_valid_first_name=false
                break
            else 
                echo "Please enter first name within 30 characters with only alphabets"
                echo 
            fi
        done

        is_valid_last_name=true

        while $is_valid_last_name;
        do
            read -p 'Last Name: ' last_name
            if [ ${#last_name} -lt 70 ] && [[ -n $last_name ]] && [[ $last_name == [a-z] || [A-Z] ]]
            then 
                is_valid_last_name=false
                break
            else 
                echo "Please enter first name within 70 characters with only alphabets"
                echo 
            fi
        done

        is_valid_mobile_num=true

        while $is_valid_mobile_num;
        do
            read -p 'Mobile Number (0xx-xxx xxxx): ' mobile_num
            if [[ -n $mobile_num ]] && [[ $mobile_num =~ ^0[0-9]{2}-[0-9]{3}" "[0-9]{4}$ ]]
            then 
                is_valid_mobile_num=false
                break
            else 
                echo "Please enter mobile number in the pattern of (0xx-xxx xxxx)"
                echo 
            fi
        done
        
        is_valid_birth_date=true

        while $is_valid_birth_date;
        do
            read -p 'Birth Date (MM-DD-YYYY): ' birth_date
            if [[ -n $birth_date ]] && [[ $birth_date =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]
            then 
                is_valid_birth_date=false
                break
            else 
                echo "Please enter birth date in the pattern of (MM-DD-YYYY)"
                echo 
            fi
        done

        is_valid_mem_type=true

        while $is_valid_mem_type;
        do
            read -p 'Membership type (Student / Public): ' membership_type
            if [[ -n $membership_type ]] && [[ $membership_type == Student ]] || [[ $membership_type == Public ]]
            then 
                is_valid_mem_type=false
                break
            else 
                echo "Please enter valid membership type (Student/Public)"
                echo 
            fi
        done

        is_valid_joined_date=true

        while $is_valid_joined_date;
        do
            read -p 'Joined Date (MM-DD-YYYY): ' joined_date
            if [[ -n $joined_date ]] && [[ $joined_date =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]
            then 
                is_valid_joined_date=false
                break
            else 
                echo "Please enter joined date in the pattern of (MM-DD-YYYY)"
                echo 
            fi
        done

        echo "$patron_id:$first_name:$last_name:$mobile_num:$birth_date:$membership_type:$joined_date" >> patron.txt
        
        add_new_patron
        ;;
        "Q")
        is_valid_choice=false
        exit 0
        ;;
        *)
        echo ">>> Please enter valid choice (y, q)!"
        ;;
        esac
    done
}

search_patron_by_id() {

    clear
    echo "Search a Patron Details"
    echo

    read -p 'Enter Patron ID: ' patron_id

    grep "$patron_id" patron.txt

    if [ $? -eq 0 ]
    then
        #something here 
        patron_id=patron_id 
    else 
        echo "There is no record for patron id $patron_id"
    fi

        echo
        echo "Press (q) to return to Patron Maintenance Menu."

        is_valid_choice=true

        while $is_valid_choice;
        do 
            echo
            read -p 'Search another patron? (y)es or (q)uit: ' search_patron_choice
            case ${search_patron_choice^^} in 
            "Y")
                is_valid_choice=false
                search_patron_by_id
                ;;
            "Q")
                is_valid_choice=false
                exit 0
                ;;
            *)
                echo ">>> Please enter valid choice (y, q)!"
            esac
        done

    
}

main_menu

