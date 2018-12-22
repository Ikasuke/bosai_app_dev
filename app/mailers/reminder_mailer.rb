class ReminderMailer < ApplicationMailer

def remind(email,item)
    @item = item
  mail to: email,
       subject: "#{@item.item_name}が#{@item.item_expiry.strftime('%Y年%m月%d日')}で期限です"
end

end
