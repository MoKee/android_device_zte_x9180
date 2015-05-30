#!/bin/sh

MYABSPATH=$(readlink -f "$0")
PATCHBASE=$(dirname "$MYABSPATH")

cd "$PATCHBASE"

export Changelog=etc/CHANGELOG-X9180.txt

if [ -f $Changelog ];
then
	rm -f $Changelog
fi

touch $Changelog

if [ -z "$CHANGELOG_DAYS" ]; then
    read -p "How many days include into changelog? [5]: " DAYS
    DAYS=${DAYS:-5}
else
    DAYS=$CHANGELOG_DAYS
fi

# Print something to build output
echo "Generating changelog ($DAYS days)..."

for i in $(seq $DAYS);
do
export After_Date=`date --date="$i days ago" +%m-%d-%Y`
k=$(expr $i - 1)
	export Until_Date=`date --date="$k days ago" +%m-%d-%Y`

	# Line with after --- until was too long for a small ListView
	echo '====================' >> $Changelog;
	echo  "     "$Until_Date       >> $Changelog;
	echo '===================='	>> $Changelog;
	echo >> $Changelog;

	# Cycle through every repo to find commits between 2 dates
	repo forall -pc 'git log --oneline --after=$After_Date --until=$Until_Date' >> $Changelog
	echo >> $Changelog;
done

sed -i 's/project/   */g' $Changelog
