#!/bin/bash -x

STAKE=100
BET_PER_MATCH=1


function findResultOfBet {

	if [ $((RANDOM%2)) -eq 0 ]
	then
		echo 1
	else
		echo 0
	fi

}



function findAmountWonPerDay {


	read -p "enter the percentage of won or loss of stake to stop betting for that day" percent

	local totalAmountPerDay=0
	local variableAmount=$(($percent*$STAKE))
	variableAmount=$(($variableAmount/100))
	local maxAmount=$variableAmount
	local minAmount=$((-1*$variableAmount))

	while [ $totalAmountPerDay -lt $maxAmount -a $totalAmountPerDay -gt $minAmount ]
	do
		local result=$(findResultOfBet)
		if [ $result -eq 1 ]
		then
			totalAmountPerDay=$(($totalAmountPerDay+$BET_PER_MATCH))
		else
			totalAmountPerDay=$(($totalAmountPerDay-$BET_PER_MATCH))
		fi
	done

	echo $totalAmountPerDay
}


totalAmountWonPerDay=$(findAmountWonPerDay)

echo $totalAmountWonPerDay




