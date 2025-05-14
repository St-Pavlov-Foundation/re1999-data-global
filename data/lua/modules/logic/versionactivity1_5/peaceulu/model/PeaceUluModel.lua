module("modules.logic.versionactivity1_5.peaceulu.model.PeaceUluModel", package.seeall)

local var_0_0 = class("PeaceUluModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0.super:ctor()

	arg_1_0.serverTaskModel = BaseModel.New()
end

function var_0_0.setActivityInfo(arg_2_0, arg_2_1)
	arg_2_0.removeNum = arg_2_1.removeNum
	arg_2_0.gameNum = arg_2_1.gameNum
	arg_2_0.hasGetBonusIds = arg_2_1.hasGetBonusIds
	arg_2_0.lastGameRecord = arg_2_1.lastGameRecord

	arg_2_0.serverTaskModel:clear()
	arg_2_0:setTasksInfo(arg_2_1.tasks)
end

function var_0_0.onGetRemoveTask(arg_3_0, arg_3_1)
	arg_3_0.taskId = arg_3_1.taskId
	arg_3_0.removeNum = arg_3_1.removeNum

	arg_3_0:setTasksInfo(arg_3_1.tasks)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function var_0_0.checkTaskId(arg_4_0)
	if arg_4_0.taskId then
		return true
	end

	return false
end

function var_0_0.cleanTaskId(arg_5_0)
	if arg_5_0.taskId then
		arg_5_0.taskId = nil
	end
end

function var_0_0.getLastGameRecord(arg_6_0)
	return arg_6_0.lastGameRecord
end

function var_0_0.onGetGameResult(arg_7_0, arg_7_1)
	arg_7_0.gameRes = arg_7_1.gameRes
	arg_7_0.removeNum = arg_7_1.removeNum
	arg_7_0.gameNum = arg_7_1.gameNum
	arg_7_0.lastSelect = arg_7_1.content

	arg_7_0:setOtherChoice()
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onGetGameResult)
end

function var_0_0.onUpdateReward(arg_8_0, arg_8_1)
	arg_8_0.hasGetBonusIds = arg_8_1.hasGetBonusIds
	arg_8_0.bonusIds = arg_8_1.bonusIds
end

function var_0_0.checkBonusIds(arg_9_0)
	if arg_9_0.bonusIds then
		return true
	end

	return false
end

function var_0_0.cleanBonusIds(arg_10_0)
	if arg_10_0.bonusIds then
		arg_10_0.bonusIds = nil
	end
end

function var_0_0.checkCanRemove(arg_11_0)
	if not arg_11_0.removeNum or arg_11_0.removeNum == 0 then
		return false
	end

	return true
end

function var_0_0.checkCanPlay(arg_12_0)
	if not arg_12_0.gameNum then
		return
	end

	if PeaceUluConfig.instance:getGameTimes() > arg_12_0.gameNum then
		return true
	end

	return false
end

function var_0_0.getRemoveNum(arg_13_0)
	if not arg_13_0.removeNum or arg_13_0.removeNum == 0 then
		return false
	end

	return arg_13_0.removeNum
end

function var_0_0.getGameHaveTimes(arg_14_0)
	if not arg_14_0.gameNum then
		return
	end

	return PeaceUluConfig.instance:getGameTimes() - arg_14_0.gameNum
end

function var_0_0.setOtherChoice(arg_15_0)
	if arg_15_0.gameRes == PeaceUluEnum.GameResult.Draw then
		arg_15_0.otherChoice = arg_15_0.lastSelect
	elseif arg_15_0.gameRes == PeaceUluEnum.GameResult.Win then
		arg_15_0.otherChoice = arg_15_0:_gameRule(arg_15_0.lastSelect, true)
	else
		arg_15_0.otherChoice = arg_15_0:_gameRule(arg_15_0.lastSelect, false)
	end
end

function var_0_0._gameRule(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == PeaceUluEnum.Game.Scissors then
		if arg_16_2 then
			return PeaceUluEnum.Game.Paper
		else
			return PeaceUluEnum.Game.Rock
		end
	elseif arg_16_1 == PeaceUluEnum.Game.Rock then
		if arg_16_2 then
			return PeaceUluEnum.Game.Scissors
		else
			return PeaceUluEnum.Game.Paper
		end
	elseif arg_16_2 then
		return PeaceUluEnum.Game.Rock
	else
		return PeaceUluEnum.Game.Scissors
	end
end

function var_0_0.getGameRes(arg_17_0)
	return arg_17_0.gameRes
end

function var_0_0.setPlaying(arg_18_0, arg_18_1)
	arg_18_0._isPlaying = arg_18_1
end

function var_0_0.isPlaying(arg_19_0)
	if arg_19_0._isPlaying == true then
		return true
	end

	return false
end

function var_0_0.getSchedule(arg_20_0)
	local var_20_0 = 0
	local var_20_1 = 0.1
	local var_20_2 = 0.955
	local var_20_3 = PeaceUluConfig.instance:getBonusCoList()
	local var_20_4 = #var_20_3
	local var_20_5 = PeaceUluConfig.instance:getProgressByIndex(1)
	local var_20_6 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity
	local var_20_7 = 0
	local var_20_8 = 0
	local var_20_9 = 0

	for iter_20_0, iter_20_1 in ipairs(var_20_3) do
		if var_20_6 >= PeaceUluConfig.instance:getProgressByIndex(iter_20_0) then
			var_20_7 = iter_20_0
			var_20_8 = PeaceUluConfig.instance:getProgressByIndex(iter_20_0)
		else
			var_20_9 = PeaceUluConfig.instance:getProgressByIndex(iter_20_0)

			break
		end
	end

	local var_20_10 = (var_20_2 - var_20_1) / (var_20_4 - 1)
	local var_20_11 = (var_20_6 - var_20_8) / (var_20_9 - var_20_8)

	if var_20_7 == var_20_4 then
		var_20_0 = 1
	elseif var_20_7 - 1 + var_20_11 <= 0 then
		var_20_0 = var_20_6 / var_20_5 * var_20_1
	else
		var_20_0 = var_20_1 + var_20_10 * (var_20_7 - 1 + var_20_11)
	end

	return var_20_0
end

function var_0_0.checkGetReward(arg_21_0, arg_21_1)
	if arg_21_0.hasGetBonusIds then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.hasGetBonusIds) do
			if iter_21_1 == arg_21_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkGetAllReward(arg_22_0)
	if arg_22_0.hasGetBonusIds and #PeaceUluConfig.instance:getBonusCoList() == #arg_22_0.hasGetBonusIds then
		return true
	end

	return false
end

function var_0_0.getOtherChoice(arg_23_0)
	return arg_23_0.otherChoice
end

function var_0_0.getTasksInfo(arg_24_0)
	return arg_24_0.serverTaskModel:getList()
end

function var_0_0.setTasksInfo(arg_25_0, arg_25_1)
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_1 = arg_25_0.serverTaskModel:getById(iter_25_1.id)

		if var_25_1 then
			var_25_1:update(iter_25_1)
		else
			local var_25_2 = PeaceUluConfig.instance:getTaskCo(iter_25_1.id)

			if var_25_2 then
				local var_25_3 = TaskMo.New()

				var_25_3:init(iter_25_1, var_25_2)
				arg_25_0.serverTaskModel:addAtLast(var_25_3)
			end
		end

		var_25_0 = true
	end

	if var_25_0 then
		arg_25_0:sortList()
	end

	return var_25_0
end

function var_0_0.sortList(arg_26_0)
	arg_26_0.serverTaskModel:sort(function(arg_27_0, arg_27_1)
		local var_27_0 = arg_27_0.finishCount > 0 and 3 or arg_27_0.progress >= arg_27_0.config.maxProgress and 1 or 2
		local var_27_1 = arg_27_1.finishCount > 0 and 3 or arg_27_1.progress >= arg_27_1.config.maxProgress and 1 or 2

		if var_27_0 ~= var_27_1 then
			return var_27_0 < var_27_1
		else
			return arg_27_0.config.id < arg_27_1.config.id
		end
	end)
end

var_0_0.instance = var_0_0.New()

return var_0_0
