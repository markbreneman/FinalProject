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
