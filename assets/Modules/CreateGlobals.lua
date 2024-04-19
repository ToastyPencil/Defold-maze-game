-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
Globals = {}

function Globals:createGlobals(self) 
	Start = string.format("%d,%d",3, Height-2)
	Goal = string.format("%d,%d",Width-2, 3)
	FINAL_TIME = 0
	PLAYER_PATH = {{}}
	TOTAL_TIME = 0
	START = os.time()
	FIRST_RUN = true
	STARTED = false
	CORRECTION = 2
	SCORE_FOUND = false
	SHAKING = true
	LOST = false
	PreviousPaths = {{}}
end

return Globals