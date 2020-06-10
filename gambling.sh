#!/bin/bash -x

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

result=$(findResultOfBet)
echo $result

