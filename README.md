FrontViewForSchedular
Specially thanks for Jiecong Wang's help.
=====================

this is a front end View which could help to add schedules in web page using rufus schedules

I scheduled my tasks with rufus-shecdular, which you could refer here: https://github.com/jmettraux/rufus-scheduler
for example  you can make a schedule in this way: scheduler.cron '25 11 * * 4' do {#your task route} end
which means your task at 11:25 every Thursday.

schedule model strores hour, minute, day parameters, which fetch parameters from task.rb file first and then write into
task.rb through File class.

for show-------------------------
schedule/index : lists  all tasks.

for add new schedule-------------
acds/editsch : editsch.html.erb gives a form for you to input 'hour', 'minute', 'day' , render parameters to 'addschedule'
acds/addschedule : get these parameters and write in to task.rb, then write into schedule database.

for delete-----------------------

schedules/destroy
overwrite the destroy method, which could remove the task from task.rb and then remove from database.
