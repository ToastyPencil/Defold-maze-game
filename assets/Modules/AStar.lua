
local Path = {}


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

function euclideanDistance(node1, node2)
	local node1lst = Mysplit(node1, ",")
	local node2lst = Mysplit(node2, ",")
	local dx = node2lst[2] - node1lst[2]
	local dy = node2lst[1] - node1lst[1] 
	return math.sqrt(dx * dx + dy * dy)
end


function manhattanDistance(node1, node2) 
	local node1lst = Mysplit(node1, ",")
	local node2lst = Mysplit(node2, ",")
	local dx = node2lst[2] - node1lst[2]
	local dy = node2lst[1] - node1lst[1] 
	return dx + dy
end

local function exists(table, indices) 
	local test = table 
	for i=1, #indices do 
		index = indices[i]
		if test[index] ~= nil then
			test = test[index]
		else 
			return false
		end
	end
	return true
end

-- A* algorithm using the Euclidean/Manhatten heuristic
function aStar(start, goal, graph)
	local sgtable = {}
	table.insert(sgtable, start)
	table.insert(sgtable, goal)
	if exists(PreviousPaths, sgtable) then
		return PreviousPaths[start][goal]
	end
	local openSet = {}
	local cameFrom = {}
	local gScore = {}
	local fScore = {}
	--gScore represents the actual distance from start for each node
	--fScore represents the heuristic distance  
	gScore[start] = 0
	fScore[start] = manhattanDistance(start, goal)

	local function reconstructPath(current)
		--takes the path starting from the goal and backtracks up its parent nodes
		local path = {current}
		while cameFrom[current] do
			current = cameFrom[current]
			table.insert(path, 1, current)
		end
		return path
	end

	openSet[start] = true
	--asigns the next node to be visited
	while next(openSet) do
		local current = 0
		local lowestFScore = math.huge
		for node in pairs(openSet) do
			if fScore[node] < lowestFScore then
				current = node
				lowestFScore = fScore[node]
			end
		end

		if current == goal then
			local usedPath = reconstructPath(goal)
			PreviousPaths[start] = {}
			PreviousPaths[start][goal] = usedPath
			return usedPath
		end

		openSet[current] = nil

		--checks whether or not is part of the fastest path
		for _, neighbor in pairs(getNeighbors(current, graph)) do
			
			local tentativeGScore = gScore[current] + manhattanDistance(current, neighbor)

			if not gScore[neighbor] or tentativeGScore < gScore[neighbor] then
				cameFrom[neighbor] = current
				gScore[neighbor] = tentativeGScore
				--assigns a heuristic distance for each of the neigboring nodes to the goal
				fScore[neighbor] = gScore[neighbor] + manhattanDistance(neighbor, goal)
				if not openSet[neighbor] then
					openSet[neighbor] = true
				end
			end
		end
	end

	return nil -- No path found
end




-- function to get the neighbors of a node 
function getNeighbors(node, Graph)
	local lst = {}
	for i=0, Graph:adj(node):size()-1 do 
		lst[i+1] = Graph:adj(node):get(i):other(node)
	end
	return lst
end


function RecordDump(o)
	local str = '{\n'
	for i=1,#o do
		str = str .."{".. tostring(o[i][2])..",".. tostring(o[i][1]).."}".. '\n'
	end
	str = str .. '}'
	return str
end



function Path:Generate(start,goal)
	local P = {{}}
	local path = aStar(start, goal, G)
	for index, tile in pairs(path) do
		P[index] = Mysplit(tile, ",")
	end
	if not FIRSTPATHFOUND then
		TOTAL_TIME = ((#P) * 0.5808159013) + 0.5799726128
		COUNTDOWN = TOTAL_TIME * 2
		FIRSTPATHFOUND = true 
	end
	return P 
end
return Path