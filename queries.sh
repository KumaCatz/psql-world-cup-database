#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(GREATEST(winner_goals, opponent_goals)) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT ")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "
  SELECT team_name
  FROM (
    SELECT winner_team.name AS team_name
    FROM games
    JOIN teams AS winner_team ON games.winner_id = winner_team.team_id
    WHERE games.year=2018
    UNION
    SELECT opponent_team.name AS team_name
    FROM games
    JOIN teams AS opponent_team ON games.opponent_id = opponent_team.team_id
    WHERE games.year=2018
  ) AS combined_teams;
")"

echo -e "\nList of unique winning team names in the whole data set:"
# echo "$($PSQL "")"

echo -e "\nYear and team name of all the champions:"
# echo "$($PSQL "")"

echo -e "\nList of teams that start with 'Co':"
# echo "$($PSQL "")"

# command to view all tables together:
# SELECT games.*, winner_team.name AS winner_team_name, opponent_team.name AS opponent_team_name FROM games JOIN teams AS winner_team ON games.winner_id = winner_team.team_id JOIN teams AS opponent_team ON games.opponent_id = opponent_team.team_id;")