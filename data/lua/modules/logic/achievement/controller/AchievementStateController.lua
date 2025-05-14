module("modules.logic.achievement.controller.AchievementStateController", package.seeall)

local var_0_0 = class("AchievementStateController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_1_0._onCheckFuncUnlock, arg_1_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_1_0._onNewFuncOpen, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:release()
end

function var_0_0._onCheckFuncUnlock(arg_3_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		return
	end

	AchievementConfig.instance:initWaitAchievements()
	arg_3_0:checkReadyAchievmeentOnline()
end

function var_0_0._onNewFuncOpen(arg_4_0, arg_4_1)
	if tabletool.indexOf(arg_4_1, OpenEnum.UnlockFunc.Achievement) then
		AchievementConfig.instance:initWaitAchievements()
		arg_4_0:checkReadyAchievmeentOnline()
	end
end

function var_0_0.checkReadyAchievmeentOnline(arg_5_0)
	local var_5_0 = AchievementConfig.instance:getWaitOnlineAchievementList()
	local var_5_1 = AchievementConfig.instance:getWaitOfflineAchievementList()

	if var_5_0 and #var_5_0 > 0 then
		arg_5_0._onlinePriorityQueue = PriorityQueue.New(function(arg_6_0, arg_6_1)
			return arg_6_0.startTime < arg_6_1.startTime
		end)

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			arg_5_0._onlinePriorityQueue:add(iter_5_1)
		end

		arg_5_0:startTickAchievementOnline()
	end

	if var_5_1 and #var_5_1 > 0 then
		arg_5_0._offlinePriorityQueue = PriorityQueue.New(function(arg_7_0, arg_7_1)
			return arg_7_0.endTime < arg_7_1.endTime
		end)

		for iter_5_2, iter_5_3 in ipairs(var_5_1) do
			arg_5_0._offlinePriorityQueue:add(iter_5_3)
		end

		arg_5_0:startTickAchievementOffline()
	end
end

function var_0_0.startTickAchievementOnline(arg_8_0)
	local var_8_0 = arg_8_0._onlinePriorityQueue:getFirst()
	local var_8_1 = arg_8_0:getAchievementStartLeftSeconds(var_8_0)

	TaskDispatcher.cancelTask(arg_8_0.onAchievementOnline, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0.onAchievementOnline, arg_8_0, var_8_1)
end

function var_0_0.onAchievementOnline(arg_9_0)
	local var_9_0 = arg_9_0._onlinePriorityQueue:getFirst()

	AchievementConfig.instance:onAchievementArriveOnlineTime(var_9_0.id)
	AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievementState)
	arg_9_0._onlinePriorityQueue:getFirstAndRemove()

	if arg_9_0._onlinePriorityQueue:getSize() > 0 then
		arg_9_0:startTickAchievementOnline()
	else
		arg_9_0._onlinePriorityQueue = nil
	end
end

function var_0_0.startTickAchievementOffline(arg_10_0)
	local var_10_0 = arg_10_0._offlinePriorityQueue:getFirst()
	local var_10_1 = arg_10_0:getAchievementEndLeftSeconds(var_10_0)

	logNormal(string.format("成就{%s}准备下架,倒计时:{%s}秒", var_10_0.id, var_10_1))
	TaskDispatcher.cancelTask(arg_10_0.onAchievementOffline, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0.onAchievementOffline, arg_10_0, var_10_1)
end

function var_0_0.onAchievementOffline(arg_11_0)
	local var_11_0 = arg_11_0._offlinePriorityQueue:getFirst()

	AchievementConfig.instance:onAchievementArriveOfflineTime(var_11_0.id)
	AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievementState)
	arg_11_0._offlinePriorityQueue:getFirstAndRemove()
	logNormal(string.format("成就{%s}下架", var_11_0.id))

	if arg_11_0._offlinePriorityQueue:getSize() > 0 then
		arg_11_0:startTickAchievementOnline()
	else
		arg_11_0._offlinePriorityQueue = nil
	end
end

function var_0_0.getAchievementStartLeftSeconds(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.startTime

	return TimeUtil.stringToTimestamp(var_12_0) - ServerTime.now()
end

function var_0_0.getAchievementEndLeftSeconds(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.endTime

	return TimeUtil.stringToTimestamp(var_13_0) - ServerTime.now()
end

function var_0_0.release(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.onAchievementOnline, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.onAchievementOffline, arg_14_0)

	arg_14_0._offlinePriorityQueue = nil
	arg_14_0._onlinePriorityQueue = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
