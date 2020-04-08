#!/bin/bash

yes_or_no () {
    while true
    do
        echo -n "Volba Y/N: "
        read -r uzivatel_volba

        case "$uzivatel_volba" in
            y|a|ano|ANO|yes|YES) return 0;;
            n|N|no|NO|ne|NE) return 1;;
            * ) echo "Chybna odpoved";;
        esac
    done
}