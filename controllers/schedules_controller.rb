class SchedulesController < ApplicationController
  # GET /schedules
  # GET /schedules.json
  def index
    
    
     File.open("c:/Users/dsun/Documents/job5search/config/initializers/task.rb",'r') do |file|
       lines=file.readlines
       @hashline=[]
       Schedule.delete_all
       lines.each{|line|                      
         if line.include? "scheduler.cron"
          @hashline<<line.chomp  
          head=line.index("'")+1
          back=line.rindex("*")-4
          m=line[head..head+1]
          h=line[back-1..back] 
          ltime=h+":"+m
          ltask=line[line.index("do")+3..line.index("end")-2]   
          lday=line[line.index("do")-3]     
          Schedule.create(:time=>ltime, :task=>ltask, :day=>lday) 
          
          end
        }      
      end
     
    
    @schedules = Schedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.json
  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])  
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(params[:schedule])

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule = Schedule.find(params[:id]) 
    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule = Schedule.find(params[:id])
    File.open("c:/Users/dsun/Documents/job5search/config/initializers/task.rb",'r+') do |file|
       @lines=file.readlines
       end
       @array=@lines
       @count=0
       @array.each do |line|                      
        
         if line.include? "scheduler.cron"       
          head=line.index("'")+1
          back=line.rindex("*")-4 
          ltime=line[back-1..back]+":"+line[head..head+1]
          ltask=line[line.index("do")+3..line.index("end")-2] 
          lday=line[line.index("do")-3]  
             if ltime==@schedule.time 
               if ltask==@schedule.task
                 if lday==@schedule.day
                @array.delete_at(@count)
                end
               end     
             end
        
          end   
        @count=@count+1
      end
      newstring=""
      @array.each do |a|  
        newstring=newstring+a
      end
       File.open("c:/Users/dsun/Documents/job5search/config/initializers/task.rb",'w') { |file|    
        file.write(newstring) }
            
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url }
      format.json { head :no_content }
    end
  end

end
