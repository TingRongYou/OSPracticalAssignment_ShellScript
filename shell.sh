#! /bin/bash

DATA_FILE="$HOME/OSPracticalAssignment_ShellScript/patron.txt"

main_menu() {
    clear
    echo "====================================="
    echo "         Patron Maintenance Menu     "
    echo "====================================="
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
            update_patron
            ;;
        "D")
            is_valid_choice=false
            delete_patron
            ;;
        "L")
            is_valid_choice=false
            sort_last_name
            ;;
        "P")
            is_valid_choice=false
            sort_patron_id
            ;;
        "J")
            is_valid_choice=false
            sort_joined_date
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
    echo "====================================="
    echo "           Add New Patron Form       "
    echo "====================================="
    echo
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
            echo "====================================="
            echo "           Add New Patron Form       "
            echo "====================================="
            echo

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
                if [[ ${#first_name} -lt 30 && $first_name =~ ^[a-zA-Z]+$ ]]; then
                    is_valid_first_name=false
                else
                    echo "Please enter a valid first name (only alphabets, max 30 characters)."
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
                if [[ $mobile_num =~ ^0[0-9]{2}-[0-9]{3}\ [0-9]{4}$ ]]; then
                    is_valid_mobile_num=false
                else
                    echo "Please enter a valid mobile number (e.g., 0xx-xxx xxxx)."
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
                if [[ $membership_type == "Student" || $membership_type == "Public" ]]; then
                    is_valid_mem_type=false
                else
                    echo "Please enter a valid membership type (Student/Public)."
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

            echo "$patron_id:$first_name:$last_name:$mobile_num:$birth_date:$membership_type:$joined_date" >> "$DATA_FILE"

            add_new_patron
            ;;
        "Q")
            is_valid_choice=false
            main_menu
            ;;
        *)
            echo ">>> Please enter valid choice (y, q)!"
            ;;
        esac
    done
}

search_patron_by_id() {

    clear
    echo "====================================="
    echo "         Search a Patron Details     "
    echo "====================================="
    echo

    read -p 'Enter Patron ID: ' patron_id

    # Search for the patron details
    patron_details=$(grep -i "^$patron_id:" patron.txt)

    if [[ -n "$patron_details" ]]; then
        # Parse and display the patron details
        IFS=":" read -r current_patron_id first_name last_name mobile_number birth_date membership_type joined_date <<< "$patron_details"

        echo
        echo "Patron ID: $current_patron_id"
        echo "First Name: $first_name"
        echo "Last Name: $last_name"
        echo "Mobile Number: $mobile_number"
        echo "Birth Date (MM-DD-YYYY): $birth_date"
        echo "Membership type: $membership_type"
        echo "Joined Date (MM-DD-YYYY): $joined_date"
        echo
    else
        echo "There is no record for patron id $patron_id"
    fi

    echo
    read -p "Press any key to return to Patron Maintenance Menu..." -n 1
    main_menu
}

update_patron() {
    clear
    echo "====================================="
    echo "         Update Patron Details       "
    echo "====================================="
    echo

    read -p "Enter Patron ID: " patron_id

    # Validation: Patron ID format (Pxxxx)
    if [[ ! "$patron_id" =~ ^P[0-9]{4}$ ]]; then
        echo "Invalid Patron ID format. Please use Pxxxx."
        return
    fi

    # Check if Patron ID exists (case-insensitive search, skip header)
    patron_details=$(sed '1d' "$DATA_FILE" | grep -i "^$patron_id:")
    if [[ -z "$patron_details" ]]; then
        echo "Patron with ID '$patron_id' not found. Please check the ID and try again."
        return
    fi

    # Fetch current patron details
    IFS=":" read -r current_patron_id first_name last_name mobile_number birth_date membership_type joined_date <<< "$patron_details"

    # Display current details
    echo
    echo "First Name: $first_name"
    echo "Last Name: $last_name"
    echo "Mobile Number: $mobile_number"
    echo "Birth Date (MM-DD-YYYY): $birth_date"
    echo "Membership type: $membership_type"
    echo "Joined Date: $joined_date"
    echo

    # Prompt for new details (only Mobile Number and Birth Date)
    echo "Enter new details (or press Enter to keep current):"

    # Validation and update for Mobile Number
    while true; do
        read -p "Mobile Number (e.g., 0xx-xxx xxxx) [$mobile_number]: " new_mobile_number
        if [[ -z "$new_mobile_number" ]]; then
            new_mobile_number="$mobile_number" # Keep current if empty
            break
        elif [[ "$new_mobile_number" =~ ^0[0-9]{2}-[0-9]{3}\ [0-9]{4}$ ]]; then
            break # Valid format
        else
            echo "Invalid Mobile Number. Please use the format 0xx-xxx xxxx."
        fi
    done

    # Validation and update for Birth Date
    while true; do
        read -p "Birth Date (MM-DD-YYYY) [$birth_date]: " new_birth_date
        if [[ -z "$new_birth_date" ]]; then
            new_birth_date="$birth_date" # Keep current if empty
            break
        elif [[ "$new_birth_date" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
            break # Valid format
        else
            echo "Invalid Birth Date. Format: MM-DD-YYYY"
        fi
    done

    # Confirm update
    echo
    echo "New Details:"
    echo
    echo "Patron ID: $current_patron_id"
    echo "First Name: $first_name"
    echo "Last Name: $last_name"
    echo "Mobile Number: $new_mobile_number"
    echo "Birth Date (MM-DD-YYYY): $new_birth_date"
    echo "Membership type: $membership_type"
    echo "Joined Date: $joined_date"
    echo

    read -p "Are you sure you want to UPDATE the above Patron Details? (y)es or (q)uit: " update_confirmation

    case ${update_confirmation,,} in
        "y")
            # Update the patron.txt file
            temp_file=$(mktemp)

            # Rebuild the file with the updated information
            while IFS=":" read -r p_id f_name l_name m_num b_date m_type j_date; do
                if [[ "$p_id" == "$patron_id" ]]; then
                    echo "$p_id:$f_name:$l_name:$new_mobile_number:$new_birth_date:$m_type:$j_date" >> "$temp_file"
                else
                    echo "$p_id:$f_name:$l_name:$m_num:$b_date:$m_type:$j_date" >> "$temp_file"
                fi
            done < "$DATA_FILE"

            mv "$temp_file" "$DATA_FILE"

            echo "Patron details updated successfully!"

            ;;
        "q")
            echo "Update cancelled."
            ;;
        *)
            echo "Invalid input. Please enter (y)es or (q)uit."
            ;;
    esac

    echo
    echo "Press (q) to return to Patron Maintenance Menu."

    read -p "Press any key to continue..."
    read -p "Update another patron? (y/n): " another_update

    if [[ "$another_update" =~ ^[Yy]$ ]]; then
        update_patron # Recursive call to update another
    else
        main_menu
    fi
}

delete_patron() {
    clear
    echo "====================================="
    echo "         Delete Patron Details       "
    echo "====================================="
    echo
    read -p "Enter Patron ID: " patron_id

    # Validation: Patron ID format (Pxxxx)
    if [[ ! "$patron_id" =~ ^P[0-9]{4}$ ]]; then
        echo "Invalid Patron ID format. Please use Pxxxx."
        return
    fi

    # Check if Patron ID exists
    if ! grep -q "^$patron_id:" "$DATA_FILE"; then
        echo "Patron with ID '$patron_id' not found."
        return
    fi

    IFS=":" read -r current_patron_id first_name last_name mobile_number birth_date membership_type joined_date < <(grep "^$patron_id:" "$DATA_FILE")

    echo
    echo "First Name: " $first_name
    echo "Last Name: " $last_name
    echo "Mobile Number: " $mobile_number
    echo "Birth Date (MM-DD-YYYY): " $birth_date
    echo "Membership type: " $membership_type
    echo "Joined Date (MM-DD-YYYY): " $joined_date
    echo

    echo "Press (q) to return to Patron Maintenance Menu."

    read -p "Are you sure you want to DELETE the above Patron Details? (y)es or (q)uit: " delete_confirmation

    case ${delete_confirmation,,} in
        "y")

            temp_file=$(mktemp)

            while IFS=":" read -r p_id f_name l_name m_num b_date m_type j_date; do
                if [[ "$p_id" != "$patron_id" ]]; then
                    echo "$p_id:$f_name:$l_name:$m_num:$b_date:$m_type:$j_date" >> "$temp_file"
                fi
            done < "$DATA_FILE"

            mv "$temp_file" "$DATA_FILE"

            echo "Patron details deleted successfully!"
            ;;

        "q")
            echo "Delete cancelled!"
            ;;

        *)
            echo "Invalid input. Please enter (y)es or (q)uit!"
            ;;
    esac

    echo
    echo "Press (q) to return to Patron Maintenance Menu."

    read -p "Press any key to continue..."
    read -p "Delete another patron? (y/n): " another_delete

    if [[ "$another_delete" =~ ^[Yy]$ ]]; then
        delete_patron # Recursive call to delete another
    else
        main_menu
    fi
}

sort_last_name() {
    clear
    echo "====================================="
    echo "   Patron Details Sorted by Last Name"
    echo "====================================="
    echo

    echo "Last Name                 First Name                Mobile Number        Joined Date     Membership Type"
    echo "----------------------------------------------------------------------------------------------------------"

    # Check if the data file exists.
    if [[ ! -f "$DATA_FILE" ]]; then
        echo "Data file not found!"
        return
    fi

    # Check if the data file is readable.
    if [[ ! -r "$DATA_FILE" ]]; then
        echo "Data file is not readable!"
        return
    fi

    # Skip the first line, sort by the third field (Last Name), and display only the required fields with adjusted formatting.
    tail -n +2 "$DATA_FILE" | sort -t ":" -k3 | awk -F ":" '{printf "%-25s %-25s %-20s %-15s %-20s\n", $3, $2, $4, $7, $6}'

    echo

    echo "Press (q) to return to Patron Maintenance Menu."
    echo

    # Ask the user if they want to export the sorted report to a file.
    read -p "Would you like to export the report as ASCII text file! (y)es (q)uit: " export_choice
    echo

    case ${export_choice,,} in
        "y" )
            read -p "Enter the file name to save the report: " export_file_name
            echo

            # Prepend "Sort_LastName_" to the file name
            export_file_name="Sort_LastName_${export_file_name}"

            # Skip the first line, sort the data, and save only the required fields with adjusted formatting to the specified file.
            tail -n +2 "$DATA_FILE" | sort -t ":" -k3 | awk -F ":" '{printf "%-25s %-25s %-20s %-15s %-20s\n", $3, $2, $4, $7, $6}' > "$export_file_name"

            echo "Report exported successfully to $export_file_name!"
            ;;
        "q" )
            echo "Export cancelled!"
            ;;
        * )
            echo "Invalid input. Please enter (y)es or (q)uit!"
            ;;
    esac

    echo
    read -p "Press any key to return to Patron Maintenance Menu..." -n 1
    main_menu
}

sort_patron_id() {
    clear
    echo "====================================="
    echo "   Patron Details Sorted by Patron ID"
    echo "====================================="
    echo

    echo "Patron ID              Last Name                 First Name                Mobile Number          Birth Date"
    echo "-------------------------------------------------------------------------------------------------------------"

    # Check if the data file exists.
    if [[ ! -f "$DATA_FILE" ]]; then
        echo "Data file not found!"
        return
    fi

    # Check if the data file is readable.
    if [[ ! -r "$DATA_FILE" ]]; then
        echo "Data file is not readable!"
        return
    fi

    # Skip the first line, sort by the first field (Patron ID), and display the required fields with adjusted formatting.
    tail -n +2 "$DATA_FILE" | sort -t ":" -k1 | awk -F ":" '{printf "%-22s %-25s %-25s %-22s %-15s\n", $1, $3, $2, $4, $5}'

    echo 

    echo "Press (q) to return to Patron Maintenance Menu."
    echo

    # Ask the user if they want to export the sorted report to a file.
    read -p "Would you like to export the report as ASCII text file! (y)es (q)uit: " export_choice
    echo

    case ${export_choice,,} in
        "y" )
            read -p "Enter the file name to save the report: " export_file_name

            echo

            # Prepend "Sort_ID_" to the file name
            export_file_name="Sort_ID_${export_file_name}"

            # Skip the first line, sort the data, and save the required fields with adjusted formatting to the file.
            tail -n +2 "$DATA_FILE" | sort -t ":" -k1 | awk -F ":" '{printf "%-22s %-25s %-25s %-22s %-15s\n", $1, $3, $2, $4, $5}' > "$export_file_name"

            echo "Report exported successfully to $export_file_name!"
            ;;

        "q" )
            echo "Export cancelled!"
            ;;

        * )
            echo "Invalid input. Please enter (y)es or (q)uit!"
            ;;
    esac

    echo
    read -p "Please press any key to return to Patron Maintenance Menu..." -n 1
    main_menu
}

sort_joined_date() {
    clear
    echo "====================================="
    echo "  Patron Details Sorted by Joined Date"
    echo "====================================="
    echo
    echo "Patron ID              Last Name                 First Name                Mobile Number          Joined Date"
    echo "-------------------------------------------------------------------------------------------------------------"

    # Check if the data file exists.
    if [[ ! -f "$DATA_FILE" ]]; then
        echo "Data file not found!"
        return
    fi

    # Check if the data file is readable.
    if [[ ! -r "$DATA_FILE" ]]; then
        echo "Data file is not readable!"
        return
    fi

    # Skip the first line, sort by the seventh field (Joined Date in descending order), and display the required fields with adjusted formatting.
    tail -n +2 "$DATA_FILE" | sort -t ":" -k7r | awk -F ":" '{printf "%-22s %-25s %-25s %-22s %-15s\n", $1, $3, $2, $4, $7}'
    echo

    echo "Press (q) to return to Patron Maintenance Menu."
    echo

    # Ask the user if they want to export the sorted report to a file.
    read -p "Would you like to export the report as ASCII text file! (y)es (q)uit: " export_choice

    echo

    case ${export_choice,,} in
        "y" )
            read -p "Enter the file name to save the report: " export_file_name
            echo

            # Prepend "Sort_JoinedDate_" to the file name
            export_file_name="Sort_JoinedDate_${export_file_name}"

            # Skip the first line, sort the data, and save the required fields with adjusted formatting to the file.
            tail -n +2 "$DATA_FILE" | sort -t ":" -k7r | awk -F ":" '{printf "%-22s %-25s %-25s %-22s %-15s\n", $1, $3, $2, $4, $7}' > "$export_file_name"

            echo "Report exported successfully to $export_file_name!"
            ;;

        "q" )
            echo "Export cancelled!"
            ;;

        * )
            echo "Invalid input. Please enter (y)es or (q)uit!"
            ;;
    esac

    echo
    read -p "Press any key to return to Patron Maintenance Menu..." -n 1
    echo

    main_menu
}

main_menu













