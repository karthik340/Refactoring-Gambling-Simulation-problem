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

	local totalAmountPerDay=0
	local variableAmount=$(($percent*$STAKE))
	local variableAmount=$(($variableAmount/100))
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


function findAmountWonFor20Days {
	local counter=0
	local AmountWonFor20Days=0
	local totalAmountWonPerDay=0
	local storeAmountPerDay
	for (( day=0;day<20;day++ ))
	do 
	totalAmountWonPerDay=$(findAmountWonPerDay)
	storeAmountPerDay[((counter++))]=$totalAmountWonPerDay
	AmountWonFor20Days=$((AmountWonFor20Days+totalAmountWonPerDay))
	done
	echo ${storeAmountPerDay[*]}
}

read -p "enter the percentage of won or loss of stake to stop betting for that day" percent

storeAmountPerDay=($(findAmountWonFor20Days))
echo "Amounts won or lost per day "
echo ${storeAmountPerDay[@]}



