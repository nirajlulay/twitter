require "rubygems"
require "twitter"
 
statuses = Twitter.public_timeline
statuses.each do |status|
    puts 'User: ' + status.user.screen_name , 'Status: ' + status.text
end