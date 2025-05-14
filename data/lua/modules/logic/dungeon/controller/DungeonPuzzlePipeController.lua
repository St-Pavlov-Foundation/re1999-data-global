module("modules.logic.dungeon.controller.DungeonPuzzlePipeController", package.seeall)

local var_0_0 = class("DungeonPuzzlePipeController", BaseController)

function var_0_0.onInitFinish(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

local var_0_1 = DungeonPuzzleEnum.dir.left
local var_0_2 = DungeonPuzzleEnum.dir.right
local var_0_3 = DungeonPuzzleEnum.dir.down
local var_0_4 = DungeonPuzzleEnum.dir.up

function var_0_0.release(arg_4_0)
	arg_4_0._rule = nil
end

function var_0_0.checkInit(arg_5_0)
	arg_5_0._rule = arg_5_0._rule or DungeonPuzzlePipeRule.New()

	local var_5_0, var_5_1 = DungeonPuzzlePipeModel.instance:getGameSize()

	arg_5_0._rule:setGameSize(var_5_0, var_5_1)
end

function var_0_0.openGame(arg_6_0, arg_6_1)
	DungeonPuzzlePipeModel.instance:initByElementCo(arg_6_1)
	arg_6_0:checkInit()
	arg_6_0:randomPuzzle()
	ViewMgr.instance:openView(ViewName.DungeonPuzzlePipeView)
end

function var_0_0.resetGame(arg_7_0)
	local var_7_0 = DungeonPuzzlePipeModel.instance:getElementCo()

	DungeonPuzzlePipeModel.instance:initByElementCo(var_7_0)
	arg_7_0:randomPuzzle()
end

function var_0_0.changeDirection(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0._rule:changeDirection(arg_8_1, arg_8_2)

	if arg_8_3 then
		arg_8_0:refreshConnection(var_8_0)
	end
end

function var_0_0.randomPuzzle(arg_9_0)
	local var_9_0 = arg_9_0._rule:getRandomSkipSet()
	local var_9_1, var_9_2 = DungeonPuzzlePipeModel.instance:getGameSize()

	for iter_9_0 = 1, var_9_1 do
		for iter_9_1 = 1, var_9_2 do
			if not var_9_0[DungeonPuzzlePipeModel.instance:getData(iter_9_0, iter_9_1)] then
				local var_9_3 = math.random(0, 3)

				for iter_9_2 = 1, var_9_3 do
					arg_9_0._rule:changeDirection(iter_9_0, iter_9_1)
				end
			end
		end
	end

	arg_9_0:refreshAllConnection()
	arg_9_0:updateConnection()
end

function var_0_0.refreshAllConnection(arg_10_0)
	local var_10_0, var_10_1 = DungeonPuzzlePipeModel.instance:getGameSize()

	for iter_10_0 = 1, var_10_0 do
		for iter_10_1 = 1, var_10_1 do
			local var_10_2 = DungeonPuzzlePipeModel.instance:getData(iter_10_0, iter_10_1)

			arg_10_0:refreshConnection(var_10_2)
		end
	end
end

function var_0_0.refreshConnection(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.x
	local var_11_1 = arg_11_1.y

	arg_11_0._rule:setSingleConnection(var_11_0 - 1, var_11_1, var_0_2, var_0_1, arg_11_1)
	arg_11_0._rule:setSingleConnection(var_11_0 + 1, var_11_1, var_0_1, var_0_2, arg_11_1)
	arg_11_0._rule:setSingleConnection(var_11_0, var_11_1 + 1, var_0_3, var_0_4, arg_11_1)
	arg_11_0._rule:setSingleConnection(var_11_0, var_11_1 - 1, var_0_4, var_0_3, arg_11_1)
end

function var_0_0.updateConnection(arg_12_0)
	DungeonPuzzlePipeModel.instance:resetEntryConnect()

	local var_12_0, var_12_1 = arg_12_0._rule:getReachTable()

	arg_12_0._rule:_mergeReachDir(var_12_0)
	arg_12_0._rule:_unmarkBranch()

	local var_12_2 = arg_12_0._rule:isGameClear(var_12_1)

	DungeonPuzzlePipeModel.instance:setGameClear(var_12_2)
end

function var_0_0.checkDispatchClear(arg_13_0)
	if DungeonPuzzlePipeModel.instance:getGameClear() then
		arg_13_0:dispatchEvent(DungeonPuzzleEvent.PipeGameClear)
	end
end

function var_0_0.getIsEntryClear(arg_14_0, arg_14_1)
	return arg_14_0._rule:getIsEntryClear(arg_14_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
