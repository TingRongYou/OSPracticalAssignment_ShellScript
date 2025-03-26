#! /bin/bash

display_menu() {
    echo "Patron Maintenance Menu"
    echo "A - Add New Patron Details"
    echo "S - Search A Patron (by Patron ID)"
    echo "U - Update a Patron Details"
    echo "D - Delete a Patron Details"
    echo "L - Sort Patrons by Last Name"
    echo "P - Sort Parons by Patron ID"
    echo "J - Sort Patrons by Joined Date (Newest to Oldest Date)"
    echo
    echo "Q - Exit from Program"
    echo
    read -p 'Please Select A Choice: ' menu_choice
}

display_menu