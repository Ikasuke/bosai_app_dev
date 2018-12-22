class ReminderMailer < ApplicationMailer

def remind(email,item)
    @item = item
  mail to: email,
       subject: "#{@item.item_name}の期限がもうすぐです"
end

end
