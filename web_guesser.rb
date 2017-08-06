require 'sinatra'
require 'sinatra/reloader'
#hello

@@secret = rand(101)
@@guesses_left = 5
 
get '/' do  
  guess = params["guess"].to_i
  msg = check_guess(guess)
  erb :index, :locals => {:number => @@secret, :msg => msg, :left => @@guesses_left}   
end

def check_guess(guess)
  if @@guesses_left == -1
    #would have done this later, but can't seem to put any code after the erb command?
    restart()
  end
  @@guesses_left -= 1  
  #msg = "hi"
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
    restart()
  end
  msg  
end

def restart()
   @@guesses_left = 5
   @@secret = rand(101)
end
