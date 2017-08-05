require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
msg = "" 
get '/' do
  guess = params["guess"].to_i
  msg = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :msg => msg} 
end

def check_guess(guess)
  msg = ""
  diff = guess - SECRET_NUMBER
  if diff > 0
    if diff > 5 
      msg = "Way too high!"
    else
      msg = "Too high!"
    end
  elsif diff < 0
    if diff < -5
      msg = "Way too low!"
    else
      msg = "Too low!"
    end
  else
    msg = "You got it right!"
  end
  msg
end 
