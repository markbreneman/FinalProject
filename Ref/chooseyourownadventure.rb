require 'rubygems'
require 'sinatra'

# STORY START;Train Select
get '/chooseyourownadventure' do 
  
  <<-HTML
  <p>You are traveling to NYU, and need to get there as soon as you can.
  You have two travel options; the 4,5 train, and the F-train.  You live 10 mins. away from each train
  The 4,5 train will put you closer to NYU, and give you the precise time that the next train will arrive, but has more stops and requires one transfer to the 6 train.
  The F-train has less stops, and according to "schedule" runs more frequently, but does not put you as close to NYU and requires a small walk once off the train.
  Which train do you choose?
  <p>
    
  <form action="/chooseyourownadventure/F-Train" method="GET">
  <!--<input type="hidden" name="F-Train" value="F-Train"> -->
  <input type="submit" value="F-Train" /></p>
  </form>
  <form action="/chooseyourownadventure/4,5 Train" method="GET">
  <!--<input type="hidden" name="4,5 Train" value="4,5 Train">-->
  <input type="submit" value="4,5 Train" /></p>
  </form>
  HTML
end

#Second Question; Wait or leave
get '/chooseyourownadventure/:trainselect' do 
  if (params[:trainselect]== "F-Train") 
    choiceTrain = "F-Train"
    otherTrain = "4,5 Train"
    message = "Do you leave and go the  #{otherTrain} or wait?"
  else
      choiceTrain = "4,5 Train"
      otherTrain = "F-Train"
      message = "The next train is scheduled to arrive in 20 minutes, do you leave and go the #{otherTrain} or wait?"
  end
  
  <<-HTML
  <p>Great you've chosen the #{choiceTrain}! Way to be decisive.  You walk to the train, and pass through the turnstyle, but as you go through the turnstyle you see your train pulling away.
  #{message} 
  <p>
    
  <form action="/chooseyourownadventure/#{choiceTrain}/Wait" method="GET">
  <!--<input type="hidden" name="Wait" value="Wait"> -->
  <input type="submit" value="Wait" /></p>
  </form>
  
  <form action="/chooseyourownadventure/#{choiceTrain}/Leave" method="GET">
  <!--<input type="hidden" name="Leave" value="Leave">-->
  <input type="submit" value="Leave" /></p>
  </form>
  
  HTML
  
end

#Third Question Action
get '/chooseyourownadventure/:trainselect/:action' do 
  if (params[:trainselect]== "F-Train") 
    choiceTrain = "F-Train"
    otherTrain = "4,5 Train"  
  else
      choiceTrain = "4,5 Train"
      otherTrain = "F-Train"
  end    
  
  if (params[:action]== "Wait") 
    choiceAction = "Wait"
    otherAction = "Leave"
    message = "So you've chosen wait; good, patience is a virtue. As you wait time passes, and you realize that you really should be going. Do you abandon ship and go to the #{otherTrain}? or hold the line?"
  else
       choiceAction = "Leave"
       otherAction = "Wait"
       message = "So you're quick to action. Responsiveness can be rewarding,and now you're off on your way to the #{otherTrain}. As you approach the #{otherTrain} the MTA annouces that the trains are delayed because of train traffic. Do you wait or double back to the #{choiceTrain}?"
  end
    
  <<-HTML
  <p>
  #{message} 
  <p>
    
  <form action="/chooseyourownadventure/#{choiceTrain}/#{choiceAction}/Wait" method="GET">
  <!--<input type="hidden" name="Wait" value="Wait"> -->
  <input type="submit" value="Wait" /></p>
  </form>
  
  <form action="/chooseyourownadventure/#{choiceTrain}/#{choiceAction}/Leave" method="GET">
  <!--<input type="hidden" name="Leave" value="Leave">-->
  <input type="submit" value="Leave" /></p>
  </form>
  
  HTML
  
end

#FINAL PAGE
get '/chooseyourownadventure/:trainselect/:action/:action2' do
  
  if (params[:action]== "Wait" && params[:action2]== "Wait" || params[:action]== "Leave" && params[:action2]== "Wait" ) 
  message= "Your patience is rewarded. Other passengers frustrated, leave, and  the train shows up early and your off to NYU with no stop. Congratulations!"  
  else
  message= "Your indecision has gotten the best of you.  You wait and wait and never get to NYU."  
  end    
  
   <<-HTML
   <p>
   #{message} 
   </p>
   
   <a href = '/chooseyourownadventure'> ReCommute </a>
   
   HTML
 end