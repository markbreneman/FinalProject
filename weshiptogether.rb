require 'sinatra'
require 'dm-core'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Contact
  include DataMapper::Resource
  
  property :id,     Serial
  property :firstname,   String
  property :lastname,   String
  property :email,  String
end
DataMapper.finalize

get '/weshiptogether' do


  <<-HTML
  <h1> WeShipTogether!</h1>
  <p> We ship together is a platform for saving on shipping here at ITP.
    It is matchmaking database pairing people who are buying from the same vendor. 
    Start by searching selecting your vendor and entering the date when you need have your order by.<p>
  <h2>The next orders from;</h2>
  <ul>
  <li>Sparkfun</li>
  <li>Adafruit</li>
  <li>Solarbotics</li>
  <li>Make</li>
  <li>McMaster</li>
  </ul>
  <h2>Who would you like to order with?</h2> 
  <form action="/weshiptogether/search" method="GET">
<ul>
<li>  <INPUT NAME=conditional TYPE=radio VALUE=\"Sparkfun"\>Sparkfun<li>
<li>  <INPUT NAME=conditional TYPE=radio VALUE=\"Adafruit"\> Adafruit<li>
<li>  <INPUT NAME=conditional TYPE=radio VALUE=\"Solarbotics"\>Solarbotics<li>
<li>  <INPUT NAME=conditional TYPE=radio VALUE=\"Make"\>Make<li>
<li>  <INPUT NAME=conditional TYPE=radio VALUE=\"McMaster"\>McMaster<li>  
<br>
</ul>
    
  <h2> When do you need your order by</h2>
  
  <input type="submit" value="SEARCH" /></p>
  </form>
  HTML
  
end









get '/emailcontactform' do 
  form = '<form action = "emailcontactform/contactpage" method ="POST">'
  form += '<p>first name <input type="text" name="firstname"/></br></p>'
  form += '<p>last name <input type="text" name="lastname"/></br></p>'
  form += '<p>email <input type="text" name="email"/></p>'
  form += '<input type="submit" value="create"/>'
end

post '/emailcontactform/contactpage' do 
  c = Contact.new
  c.firstname = params[:firstname]
  c.lastname = params[:lastname]
  c.email = params[:email]
  c.save
   
  <<-HTML
  "<H1>Thanks for your submission</H1>"
  <p><a href= '/emailcontactform/contactpage/directory' </a> View Contact Directory</p>
    HTML
end
  
  
get '/emailcontactform/contactpage/directory' do
  output=""
  space=" "
  for contact in Contact.all
      output += "<p>"
      output += contact.firstname + contact.lastname+"</br>"
      output += contact.email + "</br>"
      output += "</p>"
  end  
     output
end
