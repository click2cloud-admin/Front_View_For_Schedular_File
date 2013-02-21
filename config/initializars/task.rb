require 'rubygems'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

scheduler.cron '30 11 * * 5' do puts 'yeah' end
scheduler.cron '09 08 * * 4' do puts 'task' end
scheduler.cron '25 11 * * 4' do puts 'success' end