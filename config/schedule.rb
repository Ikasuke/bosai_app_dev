# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# ログ出力先ファイルを指定
set :output, "log/crontab.log"
# ジョブ実行環境を指定
set :environment, :production

# 毎日10:00
every 1.day, at: "11:00 am" do
  # rake タスクの実行
  rake "periodic_task:remind"
end
