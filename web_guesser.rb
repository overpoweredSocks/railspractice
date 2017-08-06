require 'sinatra'
require 'sinatra/reloader'

@@secret = rand(101)
@@guesses_left = 5
 
get '/' do  
  guess = params["guess"].to_i
  msg = check_guess(guess)
  oldNum = @@secret
  oldGuesses = @@guesses_left
  if msg.include? "You"
    restart()  
  end
  erb :index, :locals => {:number => oldNum, :msg => msg, :left => oldGuesses}   
end

def check_guess(guess)
  @@guesses_left -= 1  
  diff = guess - @@secret
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
    @@guesses_left = -1
  end
  if @@guesses_left == 0
    msg = msg + "  You lose :(. The secret number was " + @@secret.to_s
  end
  msg  
end

def restart()
   @@guesses_left = 5
   @@secret = rand(101)
end
