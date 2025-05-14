module("modules.logic.versionactivity1_3.armpipe.controller.ArmPuzzlePipeController", package.seeall)

local var_0_0 = class("ArmPuzzlePipeController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openMainView(arg_5_0)
	Activity124Rpc.instance:sendGetAct124InfosRequest(VersionActivity1_3Enum.ActivityId.Act305, arg_5_0._onOpenMainViewCB, arg_5_0)
end

function var_0_0._onOpenMainViewCB(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == 0 then
		ViewMgr.instance:openView(ViewName.ArmMainView)
	end
end

local var_0_1 = ArmPuzzlePipeEnum.dir.left
local var_0_2 = ArmPuzzlePipeEnum.dir.right
local var_0_3 = ArmPuzzlePipeEnum.dir.down
local var_0_4 = ArmPuzzlePipeEnum.dir.up

function var_0_0.release(arg_7_0)
	arg_7_0._rule = nil
end

function var_0_0.checkInit(arg_8_0)
	arg_8_0._rule = arg_8_0._rule or ArmPuzzlePipeRule.New()

	local var_8_0, var_8_1 = ArmPuzzlePipeModel.instance:getGameSize()

	arg_8_0._rule:setGameSize(var_8_0, var_8_1)
end

function var_0_0.openGame(arg_9_0, arg_9_1)
	arg_9_0._waitEpisodeCo = arg_9_1

	if not Activity124Model.instance:getEpisodeData(arg_9_1.activityId, arg_9_1.episodeId) then
		Activity124Rpc.instance:sendGetAct124InfosRequest(VersionActivity1_3Enum.ActivityId.Act305, arg_9_0._onOpenGame, arg_9_0)
	else
		arg_9_0:_onOpenGame()
	end
end

function var_0_0._onOpenGame(arg_10_0)
	local var_10_0 = arg_10_0._waitEpisodeCo

	arg_10_0._waitEpisodeCo = nil

	if var_10_0 and Activity124Model.instance:getEpisodeData(var_10_0.activityId, var_10_0.episodeId) then
		ArmPuzzlePipeModel.instance:initByEpisodeCo(var_10_0)
		arg_10_0:checkInit()
		arg_10_0:refreshAllConnection()
		arg_10_0:updateConnection()
		ViewMgr.instance:openView(ViewName.ArmPuzzlePipeView)

		local var_10_1 = var_10_0.episodeId

		arg_10_0:dispatchEvent(ArmPuzzlePipeEvent.GuideOpenGameView, var_10_1)
	end
end

function var_0_0.resetGame(arg_11_0)
	local var_11_0 = ArmPuzzlePipeModel.instance:getEpisodeCo()

	ArmPuzzlePipeModel.instance:initByEpisodeCo(var_11_0)
	arg_11_0:refreshAllConnection()
	arg_11_0:updateConnection()
	arg_11_0:dispatchEvent(ArmPuzzlePipeEvent.ResetGameRefresh)
end

function var_0_0.changeDirection(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0._rule:changeDirection(arg_12_1, arg_12_2)

	if arg_12_3 then
		arg_12_0:refreshConnection(var_12_0)
	end
end

function var_0_0.randomPuzzle(arg_13_0)
	local var_13_0 = arg_13_0._rule:getRandomSkipSet()
	local var_13_1, var_13_2 = ArmPuzzlePipeModel.instance:getGameSize()

	for iter_13_0 = 1, var_13_1 do
		for iter_13_1 = 1, var_13_2 do
			if not var_13_0[ArmPuzzlePipeModel.instance:getData(iter_13_0, iter_13_1)] then
				local var_13_3 = math.random(0, 3)

				for iter_13_2 = 1, var_13_3 do
					arg_13_0._rule:changeDirection(iter_13_0, iter_13_1)
				end
			end
		end
	end

	arg_13_0:refreshAllConnection()
	arg_13_0:updateConnection()
end

function var_0_0.refreshAllConnection(arg_14_0)
	local var_14_0, var_14_1 = ArmPuzzlePipeModel.instance:getGameSize()

	for iter_14_0 = 1, var_14_0 do
		for iter_14_1 = 1, var_14_1 do
			local var_14_2 = ArmPuzzlePipeModel.instance:getData(iter_14_0, iter_14_1)

			arg_14_0:refreshConnection(var_14_2)
		end
	end
end

function var_0_0.refreshConnection(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.x
	local var_15_1 = arg_15_1.y

	arg_15_0._rule:setSingleConnection(var_15_0 - 1, var_15_1, var_0_2, var_0_1, arg_15_1)
	arg_15_0._rule:setSingleConnection(var_15_0 + 1, var_15_1, var_0_1, var_0_2, arg_15_1)
	arg_15_0._rule:setSingleConnection(var_15_0, var_15_1 + 1, var_0_3, var_0_4, arg_15_1)
	arg_15_0._rule:setSingleConnection(var_15_0, var_15_1 - 1, var_0_4, var_0_3, arg_15_1)
end

function var_0_0.updateConnection(arg_16_0)
	ArmPuzzlePipeModel.instance:resetEntryConnect()

	local var_16_0, var_16_1 = arg_16_0._rule:getReachTable()

	arg_16_0._rule:_mergeReachDir(var_16_0)
	arg_16_0._rule:_unmarkBranch()

	local var_16_2 = arg_16_0._rule:isGameClear(var_16_1)

	ArmPuzzlePipeModel.instance:setGameClear(var_16_2)
end

function var_0_0.checkDispatchClear(arg_17_0)
	if ArmPuzzlePipeModel.instance:getGameClear() then
		arg_17_0:dispatchEvent(ArmPuzzlePipeEvent.PipeGameClear)
	end
end

function var_0_0.getIsEntryClear(arg_18_0, arg_18_1)
	return arg_18_0._rule:getIsEntryClear(arg_18_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
