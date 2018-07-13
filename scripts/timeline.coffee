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
  # どんな文字列があっても拾う
  robot.hear /.+/, (msg) ->
    # roomIDを取得
    room_id = msg.envelope.room
    room_name = robot.adapter.client.rtm.dataStore.getChannelGroupOrDMById(room_id).name
    # idにドットがあるとURLを展開してくれないので取り除く
    id = msg.message.id.replace(".","")
    message = msg.message.text
    username = msg.message.user.name
    user_id = msg.message.user.id
    reloadUserImages(robot, user_id)
    user_image = robot.brain.data.userImages[user_id]
    # ユーザ名_channelの部屋だけウォッチ対象
    if room_name.match(/^times_.+/)
      # 展開可能なURLを作成し、タイムライン表示用の部屋に投稿する
      # roomの指定で、 投稿するchannelを指定
      # 第二引数でslackのパーマネントURLを構築
      # robot.send {room: "#timeline"}, "#{slack_url}/archives/#{room_id}/p#{id}"
      request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23timeline&text=#{message}%20(at%20%23#{room_name}%20)&username=#{username}&link_names=1&pretty=1&icon_url=#{user_image}").get()
      request (err, res, body) ->