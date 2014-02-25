# Foosball gathering Hubot Script

This is a plugin for [Hubot](http://hubot.github.com/) to let users gather for a match of foosball.

## Installation

Install using ```npm install hubot-foos``` and add ```"hubot-foos"``` to the array in the external-scripts.json file.

## Commands

You can use ```hubot help``` to see list of commands.

 - foos me - Add a player.
 - foos remove - Remove a player.
 - foos clear - Remove everyone.
 - foos show - Show players.
 - foos table - Show a picture of the foosball table. You need to set HUBOT_FOOS_TABLE environment variable with a url to your webcam output.
 
## TODO
 
 - Add someone else
 - Remove someone else
 - Clear table after a few hours
 - Track score, ask each player for how many wins they had in a private message
 - Leaderboard
 - Stream images of the foosball table until the table is available
