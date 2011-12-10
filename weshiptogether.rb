require 'sinatra'
require 'dm-core'
require 'chronic'
enable :sessions

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Order
  include DataMapper::Resource
  property :id, Serial
  property :firstname,   String
  property :lastname,   String
  property :email,  String
  property :vendor, String
  property :needdate,  String
  property :inventory, String
end
DataMapper.finalize


##This is the landing page
get '/weshiptogether' do
  <<-HTML
  <h1> WeShipTogether!</h1>
  <p> We ship together is a platform for saving on shipping here at ITP.
    It is a matchmaking database pairing people who are buying from the same Vendor. 
    Start by searching selecting your Vendor and entering the date when you need have your order by.<p>
  <h2>The next orders from;</h2>
  <ul>
  <li>Sparkfun</li>
  <li>Adafruit</li>
  <li>Solarbotics</li>
  <li>Make</li>
  <li>McMaster</li>
  </ul>
  
  <h2>Quick Search</h2> 
  <form action="/weshiptogether/quicksearchresult" method="GET">
<ul>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"Sparkfun"\>Sparkfun<li>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"Adafruit"\> Adafruit<li>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"Solarbotics"\>Solarbotics<li>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"Make"\>Make<li>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"McMaster"\>McMaster<li>  
<br>
</ul>
    
  <h2> When do you need your order by</h2>
  <p>DATE <input type="text" name="needdate"/></br></p>
  <input type="submit" value="SEARCH" /></p>
  </form>
  HTML
end

##This will be the quick search result page
get '/weshiptogether/quicksearchresult' do
  #params.inspect
  output=""
  for order in Order.all
  if order.needdate == params[:needdate] && order.vendor == params[:vendor]
      output += ""
      output += "<p>  </p>"
      output += "order by date" +order.needdate+"</br>"
      output += order.firstname + order.lastname+"</br>"
      output += order.email + "</br>"
      output += "</p>"
  else
     output += "<p>Sorry but it looks like noone is placing an order with that vendor before or on your needed by date.</p>"
     output += "<p>Would you like to submit your name and order to the database?</p>"
     output += '<form action="/weshiptogether/neworder" method="GET">'
#    output += '<!--<input type="hidden" name="Yes" value="Yes"> -->'
     output += ' <input type="submit" value="Yes" /></p>'
     output += '</form>'  
     output += '<form action="/weshiptogether" method="GET">'
#    output += '<!--<input type="hidden" name="No" value="No"> -->'
     output += ' <input type="submit" value="No" /></p>'
     output += '</form>'  
  end  
end
     output
end

get '/weshiptogether/neworder' do
  <<-HTML
  <h1> WeShipTogether!</h1>
  <p> Please enter in the following information and click submit when finished. If someone has a similar order to make your contact information will be made available to them.<p>
  <form action="/weshiptogether/submittodatabase" method="POST">
<ul>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"Sparkfun"\>Sparkfun<li>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"Adafruit"\> Adafruit<li>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"Solarbotics"\>Solarbotics<li>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"MakerShed"\>MakeShed<li>
<li>  <INPUT NAME=vendor TYPE=radio VALUE=\"McMaster"\>McMaster<li>  
<br>
</ul>
  <h2> When do you need your order by</h2>
  <p>Date <input type="text" name="needdate"/></br></p>
  <h2> Contact Information</h2>
  <p>First Name <input type="text" name="firstname"/></br></p>
  <p>Last Name <input type="text" name="lastname"/></br></p>
  <p>Email <input type="text" name="email"/></br></p>
  <p>What are you buying? <input type="text" name="inventory"/></br></p>
  <input type="submit" value="Submit" /></p>
  </form>
  HTML
end


##Confirmation page after submitting to the  database
post '/weshiptogether/submittodatabase' do 
  o = Order.new
  o.firstname = params[:firstname]
  o.lastname = params[:lastname]
  o.email = params[:email]
  o.vendor = params[:vendor]
  o.needdate = params[:needdate]
  o.inventory = params[:inventory]
  o.save
   
  <<-HTML
  <H1>Thank you for your submission. If someone else is also ordering from #{params[:vendor]} and is interested in shipping with you, you will be notified.</H1>
  <p><a href= '/weshiptogether' </a> Back to Mainpage</p>
    HTML
end











