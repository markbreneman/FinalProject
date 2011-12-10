require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

#Response class
class Response
  include DataMapper::Resource
  
  property :id,        Serial
  property :name,     String
  property :position,  String
  property :markerchoice,  String
  
end

# - Main route
get '/' do
  
<<-HTML
  
  <head>
	<meta content="text/html; charset=UTF-8" />
	<meta name="description" content="TicTacToeFirstMove" />
	<title>Tic-Tac-Toe First Move</title>
	<link rel="stylesheet" type="text/css" href="TicTacToeFirstMove.css" />
  </head>
  
  <body>
  <div id="Container">
  <p><h1>The game is Tic-tac-toe</h1></p>
  <form action="/submitposition" method="POST">

  <p><h2>Are you an X or an O</h2></p>  
  <p><label>Your Name:</label> <input type="text" name="name" /></p>
  <p><input type="radio" name="markerchoice" value="markerchoice" />X</p>
  <p><input type="radio" name="markerchoice" value="markerchoice" />O</p>
  
  <p><h2>Where is your first move?</h2></p>  
  <p><input type="radio" name="position" value="position1" />position1</p>
  <p><input type="radio" name="position" value="position2" />position2</p>
  <p><input type="radio" name="position" value="position3" />position3</p>
  <p><input type="radio" name="position" value="position4" />position4</p>
  <p><input type="radio" name="position" value="position5" />position5</p>
  <p><input type="radio" name="position" value="position6" />position6</p>
  <p><input type="radio" name="position" value="position7" />position7</p>
  <p><input type="radio" name="position" value="position8" />position8</p>
  <p><input type="radio" name="position" value="position9" />position9</p>
  <p><input type="submit" value="Submit" /></p>
  </div>
  </body>
  </html>

HTML

end

# - Post Response
post '/submitposition' do
  response = Response.new
  response.name = params[:name]
  response.position = params[:markerchoice]
  response.position = params[:position]
  response.save

  counter0 = 0
  counter1 = 0
  counter2 = 0
  counter3 = 0
  counter4 = 0
  counter5 = 0
  counter6 = 0
  counter7 = 0
  counter8 = 0

  
  percent0 = 0
  percent1 = 0
  percent2 = 0
  percent3 = 0
  percent4 = 0
  percent5 = 0
  percent6 = 0
  percent7 = 0
  percent8 = 0
  
  
  output = ''

  for r in Response.all
    
    if ((r.position == "position1"))
      counter0+=1
    elsif ((r.position == "position2"))
      counter1+=1
    elsif ((r.position == "position3"))
      counter2+=1
    elsif ((r.position == "position4"))
      counter3+=1
    elsif ((r.position == "position5"))
      counter4+=1
    elsif ((r.position == "position6"))
      counter5+=1
    elsif ((r.position == "position7"))
      counter6+=1
    elsif ((r.position == "position8"))
      counter7+=1
    elsif ((r.position == "position9"))
      counter8+=1
    else
      output+="<p>error #{r.position}</p>"
    end
  end

  total = Response.count
  
  percent0 = counter0 * 100 / total
  percent1 = counter1 * 100 / total
  percent2 = counter2 * 100 / total
  percent3 = counter3 * 100 / total
  percent4 = counter4 * 100 / total
  percent5 = counter5 * 100 / total
  percent6 = counter6 * 100 / total
  percent7 = counter7 * 100 / total
  percent8 = counter8 * 100 / total
  
  #Normalizing the Percentage So there is always some indication.
  npercent0 = percent0+30
  npercent1 = percent1+30
  npercent2 = percent2+30
  npercent3 = percent3+30
  npercent4 = percent4+30
  npercent5 = percent5+30
  npercent6 = percent6+30
  npercent7 = percent7+30
  npercent8 = percent8+30

  
  halfpercent0 = percent0 / 2
  halfpercent1 = percent1 / 2
  halfpercent2 = percent2 / 2
  halfpercent3 = percent3 / 2
  halfpercent4 = percent4 / 2
  halfpercent5 = percent5 / 2
  halfpercent6 = percent6 / 2
  halfpercent7 = percent7 / 2
  halfpercent8 = percent8 / 2
  
  <<-HTML
  
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Poll Results</title>
    <link rel="stylesheet" type="text/css" href="poll.css">
    </head>
    <body>
    <div id="container">
      
    <div id="position1"> 
     <span class="circle" style=  "width: #{npercent0}px ; height: #{npercent0}px; border-radius:#{npercent0};
      background: #333;
      -moz-border-radius: #{npercent0};
      -webkit-border-radius: #{npercent0};
      padding: #{halfpercent0}:">#{percent0}%</span></div>
     <div id="position2"> 
         <span class="circle" style=  "width: #{npercent1}px ; height: #{npercent1}px; border-radius:#{npercent1};
          background: #333;
          -moz-border-radius: #{npercent1};
          -webkit-border-radius: #{npercent1};
          padding: #{halfpercent1}:">#{percent1}%</span></div>  
     <div id="position3"> 
          <span class="circle" style=  "width: #{npercent2}px ; height: #{npercent2}px; border-radius:#{npercent2};
          background: #333;
          -moz-border-radius: #{npercent2};
          -webkit-border-radius: #{npercent2};
          padding: #{halfpercent2}:">#{percent2}%</span></div>
      
      <div id="position4"> 
          <span class="circle" style=  "width: #{npercent3}px ; height: #{npercent3}px; border-radius:#{npercent3};
          background: #333;
          -moz-border-radius: #{npercent3};
          -webkit-border-radius: #{npercent3};
          padding: #{halfpercent3}:">#{percent3}%</span></div>
          
      <div id="position5"> 
          <span class="circle" style=  "width: #{npercent4}px ; height: #{npercent4}px; border-radius:#{npercent4};
          background: #333;
          -moz-border-radius: #{npercent4};
          -webkit-border-radius: #{npercent4};
          padding: #{halfpercent4}:">#{percent4}%</span></div>
         
      <div id="position6"> 
          <span class="circle" style=  "width: #{npercent5}px ; height: #{npercent5}px; border-radius:#{npercent5};
          background: #333;
          -moz-border-radius: #{npercent5};
          -webkit-border-radius: #{npercent5};
          padding: #{halfpercent5}:">#{percent5}%</span></div>     

      <div id="position7"> 
          <span class="circle" style=  "width: #{npercent6}px ; height: #{npercent6}px; border-radius:#{npercent6};
          background: #333;
          -moz-border-radius: #{npercent6};
          -webkit-border-radius: #{npercent6};
          padding: #{halfpercent6}:">#{percent6}%</span></div>
          
      <div id="position8"> 
           <span class="circle" style=  "width: #{npercent7}px ; height: #{npercent7}px; border-radius:#{npercent7};
           background: #333;
           -moz-border-radius: #{npercent7};
           -webkit-border-radius: #{npercent7};
           padding: #{halfpercent7}:">#{percent7}%</span></div>
           
       <div id="position9"> 
            <span class="circle" style=  "width: #{npercent8}px ; height: #{npercent8}px; border-radius:#{npercent8};
            background: #333;
            -moz-border-radius: #{npercent8};
            -webkit-border-radius: #{npercent8};
            padding: #{halfpercent8}:">#{percent8}%</span></div>
          
    <div id="resultMessage">Thank you for your submission heres how your selection compares to others</div>
    <img src="../Documents/00 Portfolio and Resume/00 Website/dw_site/images/TicTacToeBoard700X700 - Blank.png" alt="" width="337" height="336" />
    </div>

    </body>
    </html>
    HTML
       
end

get '/retrieve' do
  response = Response.new
  response.name = params[:name]
  response.position = params[:markerchoice]
  response.position = params[:position]
  response.save

  counter0 = 0
  counter1 = 0
  counter2 = 0
  counter3 = 0
  counter4 = 0
  counter5 = 0
  counter6 = 0
  counter7 = 0
  counter8 = 0

  
  percent0 = 0
  percent1 = 0
  percent2 = 0
  percent3 = 0
  percent4 = 0
  percent5 = 0
  percent6 = 0
  percent7 = 0
  percent8 = 0
  
  
  output = ''

  for r in Response.all
    
    if ((r.position == "position1"))
      counter0+=1
    elsif ((r.position == "position2"))
      counter1+=1
    elsif ((r.position == "position3"))
      counter2+=1
    elsif ((r.position == "position4"))
      counter3+=1
    elsif ((r.position == "position5"))
      counter4+=1
    elsif ((r.position == "position6"))
      counter5+=1
    elsif ((r.position == "position7"))
      counter6+=1
    elsif ((r.position == "position8"))
      counter7+=1
    elsif ((r.position == "position9"))
      counter8+=1
    else
      output+="<p>error #{r.position}</p>"
    end
  end

  total = Response.count
  
  percent0 = counter0 * 100 / total
  percent1 = counter1 * 100 / total
  percent2 = counter2 * 100 / total
  percent3 = counter3 * 100 / total
  percent4 = counter4 * 100 / total
  percent5 = counter5 * 100 / total
  percent6 = counter6 * 100 / total
  percent7 = counter7 * 100 / total
  percent8 = counter8 * 100 / total

  
  #Normalizing the Percentage So there is always some indication.
  npercent0 = percent0+30
  npercent1 = percent1+30
  npercent2 = percent2+30
  npercent3 = percent3+30
  npercent4 = percent4+30
  npercent5 = percent5+30
  npercent6 = percent6+30
  npercent7 = percent7+30
  npercent8 = percent8+30
  
  
  halfpercent0 = percent0 / 2
  halfpercent1 = percent1 / 2
  halfpercent2 = percent2 / 2
  halfpercent3 = percent3 / 2
  halfpercent4 = percent4 / 2
  halfpercent5 = percent5 / 2
  halfpercent6 = percent6 / 2
  halfpercent7 = percent7 / 2
  halfpercent8 = percent8 / 2
  
  <<-HTML
  
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Poll Results</title>
    <link rel="stylesheet" type="text/css" href="poll.css">
    </head>
    <body>
    <div id="container">
      
    <div id="position1"> 
     <span class="circle" style=  "width: #{npercent0}px ; height: #{npercent0}px; border-radius:#{npercent0};
      background: #333;
      -moz-border-radius: #{npercent0};
      -webkit-border-radius: #{npercent0};
      padding: #{halfpercent0}:">#{percent0}%</span></div>
     <div id="position2"> 
         <span class="circle" style=  "width: #{npercent1}px ; height: #{npercent1}px; border-radius:#{npercent1};
          background: #333;
          -moz-border-radius: #{npercent1};
          -webkit-border-radius: #{npercent1};
          padding: #{halfpercent1}:">#{percent1}%</span></div>  
     <div id="position3"> 
          <span class="circle" style=  "width: #{npercent2}px ; height: #{npercent2}px; border-radius:#{npercent2};
          background: #333;
          -moz-border-radius: #{npercent2};
          -webkit-border-radius: #{npercent2};
          padding: #{halfpercent2}:">#{percent2}%</span></div>
      
      <div id="position4"> 
          <span class="circle" style=  "width: #{npercent3}px ; height: #{npercent3}px; border-radius:#{npercent3};
          background: #333;
          -moz-border-radius: #{npercent3};
          -webkit-border-radius: #{npercent3};
          padding: #{halfpercent3}:">#{percent3}%</span></div>
          
      <div id="position5"> 
          <span class="circle" style=  "width: #{npercent4}px ; height: #{npercent4}px; border-radius:#{npercent4};
          background: #333;
          -moz-border-radius: #{npercent4};
          -webkit-border-radius: #{npercent4};
          padding: #{halfpercent4}:">#{percent4}%</span></div>
         
      <div id="position6"> 
          <span class="circle" style=  "width: #{npercent5}px ; height: #{npercent5}px; border-radius:#{npercent5};
          background: #333;
          -moz-border-radius: #{npercent5};
          -webkit-border-radius: #{npercent5};
          padding: #{halfpercent5}:">#{percent5}%</span></div>     

      <div id="position7"> 
          <span class="circle" style=  "width: #{npercent6}px ; height: #{npercent6}px; border-radius:#{npercent6};
          background: #333;
          -moz-border-radius: #{npercent6};
          -webkit-border-radius: #{npercent6};
          padding: #{halfpercent6}:">#{percent6}%</span></div>
          
      <div id="position8"> 
           <span class="circle" style=  "width: #{npercent7}px ; height: #{npercent7}px; border-radius:#{npercent7};
           background: #333;
           -moz-border-radius: #{npercent7};
           -webkit-border-radius: #{npercent7};
           padding: #{halfpercent7}:">#{percent7}%</span></div>
           
       <div id="position9"> 
            <span class="circle" style=  "width: #{npercent8}px ; height: #{npercent8}px; border-radius:#{npercent8};
            background: #333;
            -moz-border-radius: #{npercent8};
            -webkit-border-radius: #{npercent8};
            padding: #{halfpercent8}:">#{percent8}%</span></div>
          
    <div id="resultMessage">Thank you for your submission heres how your selection compares to others</div>
    <img src="../Documents/00 Portfolio and Resume/00 Website/dw_site/images/TicTacToeBoard700X700 - Blank.png" alt="" width="337" height="336" />
    </div>

    </body>
    </html>
    HTML
    
  end
