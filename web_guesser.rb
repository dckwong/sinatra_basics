require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

def check_guess guess
	if guess > 100
		message = "Too high!"
		bg = "Red"
	elsif guess < 0
		message = "Too low!"
		bg = "Red"
	elsif guess == SECRET_NUMBER
		message = "Congratulations, you got the number! " + "The SECRET NUMBER was #{SECRET_NUMBER}"
		bg = "Green"
	elsif guess > SECRET_NUMBER + 5
		message = "Your guess is way too high!"
		bg = "LightCoral"
	elsif guess < SECRET_NUMBER - 5
		message = "Your guess is way too low!"
		bg = "LightCoral"
	end
	return message, bg
end

message = ""
bg = "White"
guesses = 5
get '/' do 
	guess = params['guess'].to_i
	message, bg = check_guess(guess)
	guesses -=1
	if guess == SECRET_NUMBER
		SECRET_NUMBER = rand(100)
		guesses = 5
	elsif guesses == 0
		SECRET_NUMBER = rand(100)
		guesses = 5
		message = "You ran out of guesses!"
	end
	erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :bg => bg}
end

