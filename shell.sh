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

    isValidChoice=true

    while $isValidChoice; do
        echo
        read -p 'Please Select A Choice: ' menu_choice
        case ${menu_choice^^} in 
        "A")
        isValidChoice=false
        add_patron_form
        ;;
        "S")
        isValidChoice=false
        #Seach
        ;;
        "U")
        isValidChoice=false
        #Update
        ;;
        "D")
        isValidChoice=false
        #Delete
        ;;
        "L")
        isValidChoice=false
        #Sort(LastName)
        ;;
        "P")
        isValidChoice=false
        #Sort(PatronID)
        ;;
        "J")
        isValidChoice=false
        #Sort(Date)
        ;;
        "Q")
        isValidChoice=false
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

    isValidChoice=true

    while $isValidChoice; do 
        echo
        read -p 'Add another new patron details? (y)es or (q)uit: ' add_patron_choice
        case ${add_patron_choice^^} in 
        "Y")
        isValidChoice=false
        #AddNew 
        ;;
        "Q")
        isValidChoice=false
        exit 0
        ;;
        *)
        echo ">>> Please enter valid choice (y, q)!"
        ;;
        esac
    done
}

add_new_patron() {
    clear
    echo "Add New Patron Form"
    echo "===================="

    isValidPatronID=true

    while $isValidPatronID; do
        read -p 'Patron ID(eg: Pxxxx): ' patron_id
    done
    echo "First Name: "
    echo "Last Name: "
    echo "Mobile Number: "
    echo "Birth Date (MM-DD-YYYY): "
    echo "Membership type (Student / Public): "
    echo "Joined Date (MM-DD-YYYY): "
    echo
    echo "Press (q) to return to Patron Maintenance Menu."
}

main_menu

