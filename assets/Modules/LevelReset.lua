local clear = {}

function clear:LevelReset()
		for i=-1,Height+3 do 
			for j=-1,Width+3 do
				
					tilemap.set_tile("/level#level", "floor", j+1, i+1, 0)
					tilemap.set_tile("/level#level", "walls", j+1, i+1, 0)
				end
			end
	BRIGHT = false
	FINAL_TIME = 0 
	TOTAL_TIME = 0 
	COUNTDOWN = math.huge
	PLAYER_PATH = {}
	FIRSTPATHFOUND = false
	Start = string.format("%d,%d",3, Height-2)
	Goal = string.format("%d,%d",Width-2, 3)
	FIRST_RUN = false
	ENEMYSTARTED = false
	SCORE_FOUND = false
	SHAKING = true
	LOST = false
	PreviousPaths = {{}}
	PLAYERSTARTED = false
	
end

return clear