-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/LocalEliminateChessUtils.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.LocalEliminateChessUtils", package.seeall)

local LocalEliminateChessUtils = class("LocalEliminateChessUtils")
local Direction = {
	{
		x = 1,
		y = 0
	},
	{
		x = -1,
		y = 0
	},
	{
		x = 2,
		y = 0
	},
	{
		x = -2,
		y = 0
	}
}
local Direction2 = {
	{
		x = 0,
		y = 1
	},
	{
		x = 0,
		y = -1
	},
	{
		x = 0,
		y = 2
	},
	{
		x = 0,
		y = -2
	}
}

local function getValidCandidates(board, row, col)
	local candidates = EliminateEnum_2_7.AllChessID
	local valid = {}
	local left1 = col > 1 and board[row][col - 1] or nil
	local left2 = col > 2 and board[row][col - 2] or nil
	local up1 = row > 1 and board[row - 1][col] or nil
	local up2 = row > 2 and board[row - 2][col] or nil

	for _, num in ipairs(candidates) do
		local validNum = true

		if left1 and left2 and num == left1 and num == left2 then
			validNum = false
		end

		if up1 and up2 and num == up1 and num == up2 then
			validNum = false
		end

		if validNum then
			table.insert(valid, num)
		end
	end

	return valid
end

local function printBoard(board, _row)
	print("生成的不可消除棋盘：")

	for row = 1, _row do
		print(table.concat(board[row], " "))
	end
end

function LocalEliminateChessUtils.generateUnsolvableBoard(_row, _col)
	math.randomseed(os.time())

	local board = {}

	for i = 1, _row do
		board[i] = {}
	end

	for row = 1, _row do
		for col = 1, _col do
			local candidates = getValidCandidates(board, row, col)

			if #candidates == 0 then
				return nil
			end

			board[row][col] = candidates[math.random(#candidates)]
		end
	end

	printBoard(board, _row)

	return board
end

function LocalEliminateChessUtils.canEliminate(cells, row, col)
	local eliminatePoints = {}

	for i = 1, row do
		for j = 1, col do
			local cell = cells[i][j]

			if not cell:haveStatus(EliminateEnum.ChessState.Die) then
				local rowResult = LocalEliminateChessUtils.instance.checkWithDirection(i, j, Direction, row, col, cells)
				local colResult = LocalEliminateChessUtils.instance.checkWithDirection(i, j, Direction2, row, col, cells)

				if #rowResult == 2 then
					tabletool.clear(eliminatePoints)

					for k = 1, #rowResult do
						table.insert(eliminatePoints, rowResult[k])
					end

					local x, y = LocalEliminateChessUtils.instance._findTypeXY(cells, row, col, cell.id, rowResult)

					if x ~= nil then
						table.insert(eliminatePoints, {
							x = x,
							y = y
						})

						return eliminatePoints
					end
				end

				if #colResult == 2 then
					tabletool.clear(eliminatePoints)

					for K = 1, #colResult do
						table.insert(eliminatePoints, colResult[K])
					end

					local x, y = LocalEliminateChessUtils.instance._findTypeXY(cells, row, col, cell.id, colResult)

					if x ~= nil then
						table.insert(eliminatePoints, {
							x = x,
							y = y
						})

						return eliminatePoints
					end
				end
			end
		end
	end

	return eliminatePoints
end

function LocalEliminateChessUtils.checkWithDirection(x, y, direction, numRows, numCols, cells)
	local queue = {}
	local vis = {}

	vis[x + y * numCols] = true

	table.insert(queue, {
		x = x,
		y = y
	})

	local front = 1
	local point = queue[front]

	x = point.x
	y = point.y

	local cellModel = cells[x][y]

	front = front + 1

	if not cellModel then
		-- block empty
	else
		for i = 1, #direction do
			local diffX = direction[i].x
			local diffY = direction[i].y
			local tmpX = x + diffX
			local tmpY = y + diffY

			if tmpX < 1 or numRows < tmpX or tmpY < 1 or numCols < tmpY or vis[tmpX + tmpY * numCols] or cells[tmpX] == nil or cells[tmpX][tmpY] == nil then
				-- block empty
			elseif cellModel.id == cells[tmpX][tmpY].id and cellModel.id ~= EliminateEnum.InvalidId and cellModel.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
				vis[tmpX + tmpY * numCols] = true

				local needCheckX = -1
				local needCheckY = -1

				if math.abs(diffX) == 1 or math.abs(diffY) == 1 then
					needCheckX = x + diffX * 2
					needCheckY = y + diffY * 2
				end

				if math.abs(diffX) == 2 or math.abs(diffY) == 2 then
					needCheckX = x + (diffX ~= 0 and diffX / 2 or diffX)
					needCheckY = y + (diffY ~= 0 and diffY / 2 or diffY)
				end

				if needCheckX >= 1 and needCheckY >= 1 and needCheckX <= numRows and needCheckY <= numCols then
					local checkCell = cells[needCheckX][needCheckY]

					if checkCell ~= nil and not checkCell:haveStatus(EliminateEnum.ChessState.Frost) and LocalEliminateChessModel.instance:getSpEffect(needCheckX, needCheckY) == nil and checkCell.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone and checkCell.id ~= EliminateEnum_2_7.InvalidId then
						table.insert(queue, {
							x = tmpX,
							y = tmpY
						})
					end
				end
			end
		end
	end

	return queue
end

function LocalEliminateChessUtils._findTypeXY(cells, row, col, id, exPoints)
	if cells == nil then
		return nil, nil
	end

	for i = 1, row do
		for j = 1, col do
			local cell = cells[i][j]

			if cell.id == id and not cell:haveStatus(EliminateEnum.ChessState.Frost) and LocalEliminateChessModel.instance:getSpEffect(i, j) == nil and cell.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
				local isFind = true

				if exPoints ~= nil then
					for k = 1, #exPoints do
						local point = exPoints[k]

						if point.x == i and point.y == j then
							isFind = false

							break
						end
					end
				end

				if isFind then
					return i, j
				end
			end
		end
	end

	return nil, nil
end

local fixDrop = {
	8,
	7,
	6,
	8,
	7,
	6,
	8,
	7,
	6
}

function LocalEliminateChessUtils.getFixDropId()
	if not LengZhou6Controller.instance:isNeedForceDrop() then
		return nil
	end

	local id = table.remove(fixDrop, 1)

	return id
end

function LocalEliminateChessUtils.getChessPos(x, y)
	local posX = (x - 1) * EliminateEnum_2_7.ChessWidth + EliminateEnum_2_7.ChessIntervalX * (x - 1)
	local posY = (y - 1) * EliminateEnum_2_7.ChessHeight + EliminateEnum_2_7.ChessIntervalY * (y - 1)

	return posX, posY
end

LocalEliminateChessUtils.instance = LocalEliminateChessUtils.New()

return LocalEliminateChessUtils
