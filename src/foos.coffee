# Description
#   Add users to a foosball match.
#
# Commands:
#   foos me - Add a player.
#   foos @nick - Add @nick as a player.
#   foos remove - Remove a player.
#   foos clear - Remove everyone.
#   foos show - Show players.
#   foos table - Show a picture of the foosball table.
#
# Dependencies:
#   lodash
#
# Configuration:
#   HUBOT_FOOS_TABLE
#
# Author:
#   thorsteinsson

_ = require('lodash')

module.exports = (robot) ->
  maxLength = 4
  robot.brain.data.foos ?= {}

  getRoom = (msg) ->
    msg.message.user.room ? 'default'

  init = (msg) ->
    room = getRoom msg 
    if !robot.brain.data.foos[room]
      robot.brain.data.foos[room] = []

  showLineup = (msg) ->
    room = getRoom(msg)
    players = robot.brain.data.foos[room]
    if players.length == 0
      msg.send 'No foos players.'
    else
      msg.send 'Foos players: ' + players.join(' - ')
      
  addPlayer = (msg, nick) ->
    init msg
    players = robot.brain.data.foos[getRoom(msg)]
    players.push(nick)
    showLineup msg
    if players.length == maxLength - 1
      msg.send 'One more player needed!'
    else if players.length == maxLength
      msg.send 'Go go go!'
      robot.brain.data.foos[getRoom(msg)] = []

  robot.hear /foos\sme/i, (msg) ->
    addPlayer(msg, '@' + msg.message.user.mention_name)
      
  robot.hear /foos\s(@.*)/i, (msg) ->
    addPlayer(msg, msg.match[1])

  robot.hear /foos\sremove/i, (msg) ->
    init msg
    room = getRoom(msg)
    player = '@' + msg.message.user.mention_name
    robot.brain.data.foos[room] = _.without(robot.brain.data.foos[room], player)
    showLineup msg

  robot.hear /foos\sclear/i, (msg) ->
    robot.brain.data.foos[getRoom(msg)] = []
    showLineup msg
    
  robot.hear /foos\sshow/i, (msg) ->
    init msg
    showLineup msg

  robot.hear /foos\stable/i, (msg) ->
    msg.send process.env.HUBOT_FOOS_TABLE
