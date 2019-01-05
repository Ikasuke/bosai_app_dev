# encoding: utf-8
namespace :periodic_task do
  desc "リマインドメールの処理" # 処理の説明
  task :remind => :environment do
    @alluser = User.all
    @alluser.each do |a_user|
      @items = a_user.items
      @items.each do |item|
        if item.item_expiry.blank?
          #消費期限がなければ何もしない
        else
          delta_t = ((item.item_expiry - Time.now) / (3600 * 24)).ceil
          # 期限があと30日
          if delta_t == 30
            if a_user.remindmails.blank?
              #リマインドメールを持っていなければ何もしない
            else
              a_user.remindmails.each do |remindmail|
                ReminderMailer.remind(remindmail.remind_email, item).deliver
              end # each do end
            end # if.blank? end
          end
          # 期限があと7日
          if delta_t == 7
            if a_user.remindmails.blank?
              #リマインドメールを持っていなければ何もしない
            else
              a_user.remindmails.each do |remindmail|
                ReminderMailer.remind(remindmail.remind_email, item).deliver
              end # each do end
            end # if.blank? end
          end
          # 期限があと0日
          if delta_t == 0
            if a_user.remindmails.blank?
              #リマインドメールを持っていなければ何もしない
            else
              a_user.remindmails.each do |remindmail|
                ReminderMailer.remind(remindmail.remind_email, item).deliver
              end # each do end
            end # if.blank? end
          end # if end
        end # if blank? end
      end  # @items end
    end #allluser end
  end #task
end # namespace
