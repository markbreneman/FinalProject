require 'sinatra'
require 'dm-core'

# STEPS

# 0. Create cans in database
# 1. Create an overview page that shows all cans
# 2. create the individual form page for each can
# 3. make form saving work


DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

# declare your Rectangle object
class Can
  include DataMapper::Resource

  property :id, Serial
  property :canNum, Integer
  property :titleEnglish, String
  property :titleRussian, String
  property :titleArabic, String
  property :year, Integer
  property :reelNumber, Integer
  property :reelsTotal, Integer
  property :country, String
  property :company, String
  property :director, String
  property :audioLang, String
  property :subLang1, String
  property :subLang2, String
  property :dubbed, String
  property :link1, String
  property :link2, String
  property :link3, String
  property :notesGen, String
  property :fullTrans, String
  property :imageURL, String
end
DataMapper.finalize


get '/' do
  form = ''
  form +='<html><head>'
  form +='<link rel="stylesheet" type="text/css" href="/~mae383/sinatra/final/public/final.css"/>'
  form += '<title>Canister Database</title>'
  form +='</head>'
  form +='<body>'
  form +='<p><h2>Admin Record Creation Form</h2></p></hr>'
  form +='<form action="/~lah432/sinatra/vwtst/create_record" method="POST">'
  form +='<p><label>Album URL</label></br> <input type="text" name="imageURL" size="80" /><p>'
  form +='<p><label>Can #:</label><br /> <input type="integer" name="canNum" size="3"/></p>'
  form +='<p><label>English Title:</label><br /> <input type="text" name="titleEnglish" size="55"/></p>'
  form +='<p><label>Russian Title:</label><br /> <input type="text" name="titleRussian" size="55"/></p>'
  form +='<p><label>Arabic Title:</label><br /> <input type="integer" name="titleArabic" size="55"/></p>'
  form +='<p><label>Year:</label><br /> <input type="integer" name="year" size="4"/></p>'
  form +='<p><label>Reel Number:</label><br /> <input type="integer" name="reelNumber" size="2"/>'  
  form +='<label> of:</label> <input type="integer" name="reelsTotal" size="2"/></p>'
  form +='<p><label>Country of Origin:</label><br /> <input type="text" name="country"/></p>'
  form +='<p><label>Director:</label><br /> <input type="text" name="director" size="30"/></p>'
  form +='<p>Audio Language: <br /><select name="audioLang"><option>Arabic</option><option>English</option><option>French</option><option>Russian</option></select></p>'
  form +='<p>Dubbed? <br /><input type="checkbox" name="dubbedYes" value="dubbed"/> Yes'
  form +='<br /><input type="checkbox" name="dubbedNo" value="dubbed"/> No</p>'
  form +='<p><label>Subtitle Language 1:</label><br /><select name="audioLang"><option>Arabic</option><option>English</option><option>French</option><option>Russian</option></select></p>'
  form +='<p><label>Subtitle Language 2:</label><br /><select name="audioLang"><option>Arabic</option><option>English</option><option>French</option><option>Russian</option></select></p>'
  form +='<p><label>External Link 1:</label><br /> <input type="text" name="link1" size="80"/></p>'
  form +='<p><label>External Link 2:</label><br /> <input type="text" name="link2"size="80"/></p>'
  form +='<p><label>External Link 3:</label><br /> <input type="text" name="link3"size="80"/></p>'
  form +='<p>Is this translation as complete as it can be? <br /><input type="checkbox" name="fullTransYes" value="fullTrans"/> Yes'
  form +='<br /><input type="checkbox" name="fullTransNo" value="fullTrans"/> No</p>' 
  form +='<p><label>General Notes:</label><br /> <textarea name="notesGen" cols="100" rows="20"></textarea></p>'
  form +='<p><input type="submit" value="Submit"/><p>'
  form +='</form>'
  form +='</body>'
  form +='</html>'
  form +=''
  form
end

post '/create_record' do
  c = Can.new
  c.canNum = params[:canNum]
  c.titleEnglish =  params[:titleEnglish]
  c.titleRussian =  params[:titleRussian]
  c.titleArabic =  params[:titleArabic]
  c.year =  params[:year]
  c.reelNumber =  params[:reelNumber]
  c.reelsTotal =  params[:reelsTotal]
  c.country =  params[:country]
  c.company =  params[:company]
  c.director =  params[:director]
  c.audioLang =  params[:audioLang]
  c.subLang1 =  params[:subLang1]
  c.subLang2 =  params[:subLang2]
  c.dubbed =  params[:dubbed]
  c.link1 =  params[:link1]
  c.link2 =  params[:link2]
  c.link3 =  params[:link3]
  c.notesGen =  params[:notesGen]
  c.fullTrans =  params[:fullTrans]
  c.imageURL =  params[:imageURL]
  c.save
   
  output = ""
  s = Can.all
  for can in s
    output += "</br> #{can.canNum}"
  end
output
 # params.inspect
end
