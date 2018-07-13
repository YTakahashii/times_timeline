# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

# 自分のslackのURL
slack_url = "https://hakodatesweets2018.slack.com"

request = require 'request'
module.exports = (robot) ->
  robot.hear /.*?/i, (msg) ->
    channel = msg.envelope.room
+   room_name = robot.adapter.client.rtm.dataStore.getChannelGroupOrDMById(channel).name
    message = msg.message.text
    username = msg.message.user.name
    user_id = msg.message.user.id
    reloadUserImages(robot, user_id)
    user_image = robot.brain.data.userImages[user_id]
    if message.length > 0
      message = encodeURIComponent(message)
      link_names = if process.env.SLACK_LINK_NAMES then process.env.SLACK_LINK_NAMES else 0
      timeline_channel = if process.env.SLACK_TIMELINE_CHANNEL then process.env.SLACK_TIMELINE_CHANNEL else 'timeline'
-     request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23#{timeline_channel}&text=#{message}%20(at%20%23#{channel}%20)&username=#{username}&link_names=#{link_names}&pretty=1&icon_url=#{user_image}").get()
+     request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23#{timeline_channel}&text=#{message}%20(at%20%23#{room_name}%20)&username=#{username}&link_names=1&pretty=1&icon_url=#{user_image}").get()
      request (err, res, body) ->