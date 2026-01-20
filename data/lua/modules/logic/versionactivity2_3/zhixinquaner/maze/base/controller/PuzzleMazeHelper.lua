-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/controller/PuzzleMazeHelper.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.controller.PuzzleMazeHelper", package.seeall)

local PuzzleMazeHelper = _M
local LEFT = PuzzleEnum.dir.left
local RIGHT = PuzzleEnum.dir.right
local DOWN = PuzzleEnum.dir.down
local UP = PuzzleEnum.dir.up

function PuzzleMazeHelper.formatPos(x1, y1, x2, y2)
	if x2 < x1 then
		x1, x2 = x2, x1
	end

	if y2 < y1 then
		y1, y2 = y2, y1
	end

	return x1, y1, x2, y2
end

function PuzzleMazeHelper.getFromToDir(fromX, fromY, toX, toY)
	if fromX ~= toX then
		if fromY ~= toY then
			return nil
		end

		return fromX < toX and RIGHT or LEFT
	else
		return fromY < toY and UP or DOWN
	end
end

function PuzzleMazeHelper.getPosKey(x, y)
	return string.format("%s_%s", x, y)
end

function PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)
	local x1_f, y1_f, x2_f, y2_f = PuzzleMazeHelper.formatPos(x1, y1, x2, y2)

	return string.format("%s_%s_%s_%s", x1_f, y1_f, x2_f, y2_f)
end

return PuzzleMazeHelper
