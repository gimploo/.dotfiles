#!/usr/bin/bash

set -e

open_program (){

    echo "[*] opening $1 ..."
    $1 &
    if [ $? -eq 0 ]
    then
        echo "[!] $1 opened successfully"
    else
        echo "[!] $1 failed"
        exit 10
    fi
}

run_on_startup (){

    programs=(firefox spotify discord)

    for program in ${programs[@]}
    do
        open_program $program
    done

}

main () {

    programs=("firefox" "spotify" "discord")
    run_on_startup programs
}

main
