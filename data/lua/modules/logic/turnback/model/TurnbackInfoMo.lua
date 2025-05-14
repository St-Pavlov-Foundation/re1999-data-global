module("modules.logic.turnback.model.TurnbackInfoMo", package.seeall)

local var_0_0 = pureTable("TurnbackInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.tasks = {}
	arg_1_0.bonusPoint = 0
	arg_1_0.firstShow = true
	arg_1_0.hasGetTaskBonus = {}
	arg_1_0.signInDay = 0
	arg_1_0.signInInfos = {}
	arg_1_0.onceBonus = false
	arg_1_0.endTime = 0
	arg_1_0.startTime = 0
	arg_1_0.remainAdditionCount = 0
	arg_1_0.leaveTime = 0
	arg_1_0.monthCardAddedBuyCount = 0
	arg_1_0.newType = true
	arg_1_0.hasBuyDoubleBonus = false
	arg_1_0.config = nil
	arg_1_0.dropinfos = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.tasks = arg_2_1.tasks
	arg_2_0.bonusPoint = arg_2_1.bonusPoint
	arg_2_0.firstShow = arg_2_1.firstShow
	arg_2_0.hasGetTaskBonus = arg_2_1.hasGetTaskBonus
	arg_2_0.signInDay = arg_2_1.signInDay
	arg_2_0.signInInfos = arg_2_1.signInInfos
	arg_2_0.onceBonus = arg_2_1.onceBonus
	arg_2_0.startTime = tonumber(arg_2_1.startTime)
	arg_2_0.endTime = tonumber(arg_2_1.endTime)
	arg_2_0.leaveTime = tonumber(arg_2_1.leaveTime)
	arg_2_0.monthCardAddedBuyCount = tonumber(arg_2_1.monthCardAddedBuyCount)

	arg_2_0:setRemainAdditionCount(arg_2_1.remainAdditionCount, true)

	arg_2_0.newType = arg_2_1.version == TurnbackEnum.type.New and true or false
	arg_2_0.hasBuyDoubleBonus = arg_2_1.buyDoubleBonus
	arg_2_0.config = TurnbackConfig.instance:getTurnbackCo(arg_2_0.id)
	arg_2_0.dropinfos = arg_2_1.dropInfos
end

function var_0_0.isStart(arg_3_0)
	return ServerTime.now() - arg_3_0.startTime >= 0
end

function var_0_0.isEnd(arg_4_0)
	return ServerTime.now() - arg_4_0.endTime > 0
end

function var_0_0.isInReommendTime(arg_5_0)
	return arg_5_0.leaveTime > 0 and ServerTime.now() - arg_5_0.leaveTime >= 0
end

function var_0_0.isInOpenTime(arg_6_0)
	local var_6_0 = arg_6_0:isStart()
	local var_6_1 = arg_6_0:isEnd()

	return var_6_0 and not var_6_1
end

function var_0_0.isNewType(arg_7_0)
	return arg_7_0.newType
end

function var_0_0.updateHasGetTaskBonus(arg_8_0, arg_8_1)
	arg_8_0.hasGetTaskBonus = arg_8_1
end

function var_0_0.setRemainAdditionCount(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	if arg_9_1 and arg_9_1 > 0 then
		var_9_0 = arg_9_1
	end

	local var_9_1 = arg_9_0.remainAdditionCount ~= var_9_0

	arg_9_0.remainAdditionCount = var_9_0

	if var_9_1 and not arg_9_2 then
		TurnbackController.instance:dispatchEvent(TurnbackEvent.AdditionCountChange, arg_9_0.id)
	end
end

function var_0_0.isRemainAdditionCount(arg_10_0)
	return arg_10_0:getRemainAdditionCount() > 0
end

function var_0_0.isAdditionInOpenTime(arg_11_0)
	local var_11_0 = TurnbackConfig.instance:getAdditionDurationDays(arg_11_0.id)

	return ServerTime.now() - arg_11_0.startTime < var_11_0 * TimeUtil.OneDaySecond
end

function var_0_0.isAdditionValid(arg_12_0)
	local var_12_0 = arg_12_0:isInOpenTime()
	local var_12_1 = arg_12_0:isAdditionInOpenTime()
	local var_12_2 = arg_12_0:isRemainAdditionCount()

	return var_12_0 and var_12_1 and var_12_2
end

function var_0_0.getRemainAdditionCount(arg_13_0)
	return arg_13_0.remainAdditionCount
end

function var_0_0.getBuyDoubleBonus(arg_14_0)
	return arg_14_0.hasBuyDoubleBonus
end

return var_0_0
