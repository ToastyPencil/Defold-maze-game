
mathR = require("assets.Modules.MTRandom")

Maze = {}



G = require("assets.Modules.Graph").create(0)

function RandomWithStep(first, last, stepSize)
	local maxSteps = math.floor((last-first)/stepSize)
	return first + stepSize * mathR.random(0, maxSteps)
end

--creates an empty grid lattice 
function CreateEmptyGrid(Width, Height)
local Grid = {}
for i = 1, Height do
	Grid[i] = {}
	for j = 1, Width do
		--unvisted open spaces are represented by "1"
		Grid[i][j] = "1"
		if (i-1)%2 == 1 or (j-1)%2 == 1 then
			--walls are represented by "0"
			Grid[i][j] = "0"
		end
		if(i==2 or j==2 or i==Height-1 or j==Width-1)then
			Grid[i][j] = "0"
		end
		if (i==1 or j==1 or i==Height or j ==Width) then
			--visited spaces are represented by " "
			Grid[i][j] = " "
		end




	end
end
return Grid
end

--splits the string coordinates into a table
function Mysplit (inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end



function Generate(cx, cy, grid)
	--sets the current coordinate to visited
	grid[cy][cx] = " "
	--base case: checks if there are any more unvisted cells adjacent to the current coordinate
	if grid[cy -2][cx] == " " and grid[cy + 2][cx] == " " and
	grid[cy][cx - 2] == " " and grid[cy][cx + 2] == " " then
		return
	else
		--list of unchecked directions from each coordinate
		local li = {1,2,3,4}
		-- n represents the open space the algorithm carves a path to
		--m represents the wall removed to get to the open unvisted space
		local idx = 0
		local choice = 0
		local nx=0
		local mx=0
		local ny=0
		local my=0
		while #li > 0 do
			idx = mathR.random(1,#li)
			--print(idx)
			choice = li[idx]
			--changes to each coordinate's adjacent list are local to each function call
			table.remove(li, idx)
			if choice == 1 then
				nx = cx
				mx = cx 
				ny = cy-2
				my = cy-1 
			elseif choice == 2 then
				nx = cx
				mx = cx 
				ny = cy+2
				my = cy+1 
			elseif choice == 3 then
				nx = cx-2
				mx = cx -1
				ny = cy
				my = cy
			elseif choice == 4 then
				nx = cx+2
				mx = cx + 1
				ny = cy
				my = cy
			else

				mx = cx
				nx=cx
				ny=cy
				my=cy

			end
			--checks if the open coordinate was visited and if not, breaks the wall between them
			if  grid[ny][nx] ~=" " then
				grid[my][mx] = " "
				--adds an edge to the graph between each of the adjacent cells 
				G:addEdge(string.format("%d,%d", cy,cx),string.format("%d,%d", my,mx))
				G:addEdge(string.format("%d,%d", my,mx), string.format("%d,%d", ny,nx))
				--recursive call
				Generate(nx, ny, grid)
				




			end


		end
	end  
end



--constructor function of the module that is called from a different file
function Maze:generate(Height, Width)
	G = require("assets.Modules.Graph").create(0)
	local M = CreateEmptyGrid(Width, Height)
	Sy = RandomWithStep(3, Height-3, 2)
	Sx = RandomWithStep(3,Width-3,2)
	Generate(5,5, M)
	return M
end

return Maze





