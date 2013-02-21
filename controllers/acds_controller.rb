class AcdsController < ApplicationController
  # GET /acds
  # GET /acds.json  
  def index
   
  if params[:search].present?
        if !params[:Distance].nil?
        if !params[:Distance].empty? 
          @Distance = params[:Distance] 
        end
      end
    @acds = Acd.near(params[:search], @Distance, :order => :distance)
  else
     @acds = Acd.all
  end
  
 sql=''  
  @per_page=8
  @architect = false
      if !params[:architect].nil?
        if params[:architect]
          sql = sql + " architect=" + ActiveRecord::Base.connection.quoted_true + " AND "
          @architect = true
        end
      end

  @gc = false
      if !params[:gc].nil?
        if params[:gc] 
          sql = sql + " gc=" + ActiveRecord::Base.connection.quoted_true + " AND "
          @gc = true
        end
      end
  if sql.empty?
        #sql = "SELECT * FROM testbooleanboxes ORDER BY testbooleanbox_id "      
      else
        #sql = "SELECT * FROM testbooleanboxes WHERE " + sql[0..sql.length-5]
       @acds = Acd.near(params[:search], @Distance, :order => :distance).where(sql[0..sql.length-5])
       Tempacd.delete_all
       @acds.each do |ac|
        Tempacd.create(:first_name =>ac.first_name,:last_name =>ac.last_name, :email =>ac.email, :encrypted_password=>ac.encrypted_password, :phone=>ac.phone,
        :skype=>ac.skype, :facebook=>ac.facebook, :twitter=>ac.twitter, :longitude=>ac.longitude, :latitude=>ac.latitude,:location=>ac.location,
        :architect=>ac.architect,:gc=>ac.gc).save
        end
       @tempacds=Acd.find_by_sql("SELECT * FROM acds
       WHERE email NOT IN (SELECT email FROM tempacds)")
      end
      
      
 
  respond_to do |format|
      format.html # index.html.erb
      if sql.empty?
      format.json { render json: @acds }
      else
      format.json { render json: @acds }
      format.json { render json: @tempacds }
      end
    end
  end
  
  
  
  def anotherindex
   
  if params[:search].present?
        if !params[:Distance].nil?
        if !params[:Distance].empty? 
          @Distance = params[:Distance] 
        end
      end
    @acds = Acd.near(params[:search], @Distance, :order => :distance)
  else
     @acds = Acd.all
  end
  
 sql=''  
  @per_page=8
  @architect = false
      if !params[:architect].nil?
        if params[:architect]
          sql = sql + " architect=" + ActiveRecord::Base.connection.quoted_true + " AND "
          @architect = true
        end
      end

  @gc = false
      if !params[:gc].nil?
        if params[:gc] 
          sql = sql + " gc=" + ActiveRecord::Base.connection.quoted_true + " AND "
          @gc = true
        end
      end
  if sql.empty?
        #sql = "SELECT * FROM testbooleanboxes ORDER BY testbooleanbox_id "      
      else
        #sql = "SELECT * FROM testbooleanboxes WHERE " + sql[0..sql.length-5]
       @acds = Acd.near(params[:search], @Distance, :order => :distance).where(sql[0..sql.length-5])
       Tempacd.delete_all
       @acds.each do |ac|
        Tempacd.create(:first_name =>ac.first_name,:last_name =>ac.last_name, :email =>ac.email, :encrypted_password=>ac.encrypted_password, :phone=>ac.phone,
        :skype=>ac.skype, :facebook=>ac.facebook, :twitter=>ac.twitter, :longitude=>ac.longitude, :latitude=>ac.latitude,:location=>ac.location,
        :architect=>ac.architect,:gc=>ac.gc).save
        end
       @tempacds=Acd.find_by_sql("SELECT * FROM acds
       WHERE email NOT IN (SELECT email FROM tempacds)")
      end
      
      
 
  respond_to do |format|
      format.html # index.html.erb
      if sql.empty?
      format.json { render json: @acds }
      else
      format.json { render json: @acds }
      format.json { render json: @tempacds }
      end
    end
  end
  
  
  
  
  
  # GET /acds/1
  # GET /acds/1.json
  def show
    @acd = Acd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @acd }
    end
  end

  # GET /acds/new
  # GET /acds/new.json
  def new
    @acd = Acd.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @acd }
    end
  end

  # GET /acds/1/edit
  def edit
    @acd = Acd.find(params[:id])
  end

  # POST /acds
  # POST /acds.json
  def create
    @acd = Acd.new(params[:acd])

    respond_to do |format|
      if @acd.save
        format.html { redirect_to @acd, notice: 'Acd was successfully created.' }
        format.json { render json: @acd, status: :created, location: @acd }
      else
        format.html { render action: "new" }
        format.json { render json: @acd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /acds/1
  # PUT /acds/1.json
  def update
    @acd = Acd.find(params[:id])

    respond_to do |format|
      if @acd.update_attributes(params[:acd])
        format.html { redirect_to @acd, notice: 'Acd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @acd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acds/1
  # DELETE /acds/1.json
  def destroy
    @acd = Acd.find(params[:id])
    @acd.destroy

    respond_to do |format|
      format.html { redirect_to acds_url }
      format.json { head :no_content }
    end
  end
  
  def sendmail
    #acds = []
    #params[:selacds].each do |p|
    #acds << Acd.find_by_id(p)
    #end   
     # acds = Acd.all
    if params[:selacds].present?
    acds = []
    params[:selacds].each do |p|
    acds << Acd.find_by_id(p)
    end
      else
     acds = Acd.all
    end
    
      if params[:email].present?  
      acds.each do |a|
      recipient= a.email      
      email = params[:email]
      subject = email[:subject]
      message = email[:message]  

      AcdMailer.confirm(recipient, subject, message).deliver
      return if request.xhr?         
      end 
      
      else
        acds.each do |a|
        recipient= a.email 
        end
        AcdMailer.defaultmail(recipient).deliver        
      end 
       render :text => 'Message sent successfully'  
    end  
    
    
    def defaultmail
     acds = Acd.all
     acds.each do |a|
      recipient= a.email 
      AcdMailer.defaultmail(recipient).deliver  
      end   
      render :text => 'Message sent successfully'           
    end
   
   def  addschedule
     
     if params[:taskroute].present?
       if !params[:hour].nil?
        if !params[:hour].empty?     
         if !params[:minute].nil?
          if !params[:minute].empty?
            if !params[:day].nil?
          if !params[:day].empty?          
          @hour = params[:hour]          
          @minute = params[:minute] 
          @task=params[:taskroute]
          @day=params[:day]
        File.open("c:/Users/dsun/Documents/job5search/config/initializers/task.rb",'a') { |file|    
        file.write("\nscheduler.cron '"+@minute+" "+@hour+" * * "+@day+"' do "+@task+" end") }
        newtime=@hour+":"+@minute
        Schedule.create(:time=>newtime, :task=>@task, :day=>@day) 
        
        end 
        end
        end 
        end 
        end
        end
        end
      redirect_to :controller => 'schedules', :action => 'index'
   end
 
end
