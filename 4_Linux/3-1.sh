#! /bin/bash

function getRate()
{
    url="https://finance.tut.by/kurs/"
    if [ $1 == "USD" ]; then
        urlCurrency="dollar"
    elif [ $1 == "EUR" ]; then
        urlCurrency="euro"
    fi
    # gets html page from $url and parses it twice: finds string and value inside the string
    # wget options: -q - do not print anything, -O- - print downloaded page to stdout
    # grep options: -P - enable Perl regex, -o - show only matched part of file 
    rate=$(wget -q -O - $url | grep "https://finance.tut.by/kurs/minsk/$urlCurrency/?sortBy=sell&sortDir=up" | grep -Po '<p>\K[0-9.]*')
    echo "The best rate $1 -> BYR is: $rate"
}

if [ $# -eq 1 ]; then
    if [ $1 == "USD" ] || [ $1 == "EUR" ]; then
        getRate $1
        exit
    else
        echo "Error! Please, choose between USD and EUR"
    fi
else
    select currency in USD EUR
    do
        case $currency in 
        USD | EUR) 
            getRate $currency ;;
        *)
            echo "Error! Please, choose between USD and EUR"
            continue
        esac
    
        break
    done
fi