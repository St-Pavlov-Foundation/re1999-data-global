module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueEndingInfoMO", package.seeall)

local var_0_0 = pureTable("RogueEndingInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._activityId = arg_1_1.activityId
	arg_1_0._difficulty = arg_1_1.difficulty
	arg_1_0._heros = arg_1_1.heroId
	arg_1_0._roomId = arg_1_1.roomId
	arg_1_0._roomNum = arg_1_1.roomNum
	arg_1_0._currencyTotal = arg_1_1.currencyTotal
	arg_1_0._collections = arg_1_1.collections
	arg_1_0._isFinish = arg_1_1.isFinish
	arg_1_0._score = arg_1_1.score
	arg_1_0._doubleScore = arg_1_1.doubleScore
	arg_1_0._bonus = arg_1_1.bonus
	arg_1_0._ending = arg_1_1.ending
	arg_1_0._layer = arg_1_1.layer
	arg_1_0._failReason = arg_1_1.failReason

	arg_1_0:initFinishEvents(arg_1_1)

	arg_1_0._isEnterEndingFlow = false
end

function var_0_0.initFinishEvents(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.finishEvents

	arg_2_0.finishEventList = arg_2_0.finishEventList or {}

	tabletool.clear(arg_2_0.finishEventList)

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			table.insert(arg_2_0.finishEventList, iter_2_1)
		end
	end
end

function var_0_0.getFinishEventList(arg_3_0)
	return arg_3_0.finishEventList
end

function var_0_0.getFinishEventNum(arg_4_0)
	return arg_4_0.finishEventList and #arg_4_0.finishEventList or 0
end

function var_0_0.getLayer(arg_5_0)
	return arg_5_0._layer
end

function var_0_0.getRoomNum(arg_6_0)
	return arg_6_0._roomNum
end

function var_0_0.getDifficulty(arg_7_0)
	return arg_7_0._difficulty
end

function var_0_0.getScore(arg_8_0)
	return arg_8_0._score
end

function var_0_0.isDoubleScore(arg_9_0)
	return arg_9_0._doubleScore > 0
end

function var_0_0.isFinish(arg_10_0)
	return arg_10_0._isFinish
end

function var_0_0.getFailReason(arg_11_0)
	return arg_11_0._failReason
end

function var_0_0.onEnterEndingFlow(arg_12_0)
	arg_12_0._isEnterEndingFlow = true
end

function var_0_0.isEnterEndingFlow(arg_13_0)
	return arg_13_0._isEnterEndingFlow
end

return var_0_0
