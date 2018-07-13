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
slack_url = "https://hakodatesweets2018.slack.com/"

module.exports = (robot) ->
  # どんな文字列があっても拾う
  robot.hear /.+/, (msg) ->
    room = msg.envelope.room
    # idにドットがあるとURLを展開してくれないので取り除く
    id = msg.message.id.replace(".","")

    # ユーザ名_channelの部屋だけウォッチ対象
    if room.match(/^times_.+/)
      # 展開可能なURLを作成し、タイムライン表示用の部屋に投稿する
      # roomの指定で、 投稿するchannelを指定
      # 第二引数でslackのパーマネントURLを構築
      robot.send {room: "#times_timeline"}, "#{slack_url}/archives/#{room}/p#{id}"