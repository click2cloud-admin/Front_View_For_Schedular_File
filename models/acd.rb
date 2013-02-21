class Acd < ActiveRecord::Base
  # DISTANCES = ["500", "400", "300", "200", "100"]
 
  

  attr_accessible :email, :encrypted_password, :facebook, :first_name, :last_name, :phone, :skype, :twitter, :longitude,:latitude, :location, :aorgc, :architect, :gc
  geocoded_by :location                # must be full address with city and state
  after_validation :geocode       # auto-fetch coordinates
 

     DISTANCES = ["100", "200", "300", "400","500"]   
     
     MINUTES=[ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19","20",
    "21", "22", "23", "24", "25", "26", "27", "28", "29", "30","31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
    "41", "42", "43", "44", "45", "46", "47", "48", "49", "50","51", "52", "53", "54", "55", "56", "57", "58", "59"]
    HOURS=[ "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", 
    "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22","23"] 
     DAYS=[ "1", "2", "3", "4", "5", "6", "7"]
     
   def self.defaultmail
     logger.debug "Opening acd model"
     acds = Acd.all
     acds.each do |a|
      recipient= a.email 
      AcdMailer.defaultmail(recipient).deliver  
      end  

    end
   
     
     
end

  