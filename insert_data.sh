#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if (($YEAR != year))
  then

    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    if [[ -z $TEAM_ID ]]
    then
      TEAM_ID_VALUE=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")

      if [[ $TEAM_ID_VALUE == 'INSERT 0 1' ]]
      then
        echo "$WINNER was added to the team's roster"
      fi
    fi

    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    if [[ -z $TEAM_ID ]]
    then
      TEAM_ID_VALUE=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")

      if [[ $TEAM_ID_VALUE == 'INSERT 0 1' ]]
      then
        echo "$OPPONENT was added to the team's roster"
      fi
    fi

    ## insert all games
    # get winner id and opponent id:
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    GAME_VALUE=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ $GAME_VALUE == 'INSERT 0 1' ]]
      then
        echo "The following game was added: Year $YEAR, $ROUND round, $WINNER against $OPPONENT, result of $WINNER_GOALS : $OPPONENT_GOALS"
      fi
  fi
done