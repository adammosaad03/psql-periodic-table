#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then 
 echo "Please provide an element as an argument."
else
ELEMENT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.symbol='$1' OR elements.name='$1'")
if [[ $1 =~ ^[0-9]$ ]]
then
ELEMENT=$($PSQL "SELECT * FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.atomic_number=$1")
fi
if [[  -z $ELEMENT  ]]
then
echo "I could not find that element in the database."
else 

 echo $ELEMENT |  while IFS='|' read TYPE_ID NUMBER MASS MELTING BOILING  SYMBOL NAME TYPE
 do
 echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
 done
 fi

fi
