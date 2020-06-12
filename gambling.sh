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

function findMaxAndMinAmountPerDay {

variableAmount=$(($percent*$STAKE))
variableAmount=$(($variableAmount/100))
maxAmount=$variableAmount
minAmount=$((-1*$variableAmount))

}


function findAmountWonPerDay {

	local totalAmountPerDay=0
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


function findLuckiestAndUnLuckiestDays {


	local storeArray=($(echo "$@"))

	luckyDay=1
	unLuckyDay=1
	local cumulativeAmount=0
	local amountOnLuckyDay=0
	local amountOnUnLuckyDay=0

	local day=1
	for amountWonPerDay in ${storeArray[@]}
	do
		cumulativeAmount=$(($cumulativeAmount+$amountWonPerDay))
		if [ $cumulativeAmount -gt $amountOnLuckyDay ]
		then
			amountOnLuckyDay=$cumulativeAmount
			luckyDay=$day	
		fi
		if [ $cumulativeAmount -lt $amountOnUnLuckyDay ]
		then
			amountOnUnLuckyDay=$cumulativeAmount
			unLuckyDay=$day	
		fi 
		day=$(($day+1))
	done
	echo "$luckyDay $unLuckyDay $cumulativeAmount"
}

function checkToContinueNextMonth {

	local totalAmountWonFor20Days=$1
	if [ $totalAmountWonFor20Days -gt 0 ]
	then
		echo 1
	else
		echo 0
	fi

}


function startGambling {

checkToContinue=1
while [ $checkToContinue -eq 1 ]
do
	storeAmountPerDay=($(findAmountWonFor20Days))

	arg1=$(echo ${storeAmountPerDay[@]})
	read luckyDay unLuckyDay totalAmountFor20Days < <(findLuckiestAndUnLuckiestDays $arg1)

	echo "luckiest day = "$luckyDay
	echo "unluckiestday = "$unLuckyDay
	echo "Amount won for 20 days = "$totalAmountFor20Days
	echo " "
	echo ${storeAmountPerDay[@]}
	checkToContinue=$(checkToContinueNextMonth $totalAmountFor20Days)
	if [ $checkToContinue -eq 1 ]
	then
		read -p "do you wan to continue for next month 1.Yes 2.No " checkToContinue 
	else
		checkToContinue=0	
	fi
done
}

read -p "enter the percentage of won or loss of stake to stop betting for that day" percent
findMaxAndMinAmountPerDay
startGambling















