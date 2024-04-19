-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
require("assets.Modules.Graph")
require("assets.Modules.List")

local Map = {}

local mathR = require("assets.Modules.MTRandom")

function Map:TilePlacer(Height, Width)



for i=0,Height+1 do 
	for j=0,Width+1 do
		local prob = mathR.random(1, 7)
		if prob < 3 then
			tilemap.set_tile("/level#level", "floor", j+1, i+1, 142)
		else 
			tilemap.set_tile("/level#level", "floor", j+1, i+1, 143)
		end
	end
end

Maze = require("assets.Modules.MazeGenerator"):generate(Height, Width)
for i=1,Height do 
	for j=1,Width do 
		--checks whether it is a wall or not
		if Maze[i][j] == "0" then
			local tileNumber = mathR.random(1,190)
			if tileNumber == 142 or tileNumber == 143 then
				tileNumber = tileNumber - 2
			end
			tilemap.set_tile("/level#level", "walls", j+1, i+1, tileNumber)

		end



	--sets a barrier that the player cannot walk outside (prevents from going  out of bounds)
		if i == 1 or j == 1 then
			tilemap.set_tile("/level#level", "walls", j, i, 52)
		end
		if i==Height or j==Width then
			tilemap.set_tile("/level#level", "walls", j+2, i+2, 52)
	end 

	end
end
tilemap.set_tile("/level#level", "walls", 4, Height, 0)
tilemap.set_tile("/level#level", "walls", Width-1, 3, 0)
tilemap.set_tile("/level#level", "walls", 3, Height+1, 52)
tilemap.set_tile("/level#level", "walls", Width-2, 2, 52)
tilemap.set_tile("/level#level", "walls", 5, Height+1, 52)
tilemap.set_tile("/level#level", "walls", Width, 2, 52)
tilemap.set_tile("/level#level", "walls", 1, Height+2, 52)
tilemap.set_tile("/level#level", "walls", 2, Height+2, 52)
tilemap.set_tile("/level#level", "walls", 1, Height+1, 52)
tilemap.set_tile("/level#level", "walls", Width+2, 1, 52)
tilemap.set_tile("/level#level", "walls", Width+2, 2, 52)
tilemap.set_tile("/level#level", "walls", Width+1, 1, 52)


end

return Map