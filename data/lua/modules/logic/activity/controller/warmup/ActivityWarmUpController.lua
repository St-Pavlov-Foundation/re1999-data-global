module("modules.logic.activity.controller.warmup.ActivityWarmUpController", package.seeall)

local var_0_0 = class("ActivityWarmUpController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.init(arg_3_0, arg_3_1)
	logNormal("ActivityWarmUpController init actId = " .. tostring(arg_3_1))

	local var_3_0 = ActivityModel.instance:getActMO(arg_3_1)

	ActivityWarmUpModel.instance:init(arg_3_1)

	if var_3_0 then
		ActivityWarmUpModel.instance:setStartTime(var_3_0.startTime)
	end

	local var_3_1 = ActivityWarmUpModel.instance:getCurrentDay()

	arg_3_0:switchTab(var_3_1 or 1)
end

function var_0_0.onReceiveInfos(arg_4_0, arg_4_1, arg_4_2)
	if ActivityWarmUpModel.instance:getActId() == arg_4_1 then
		ActivityWarmUpModel.instance:setServerOrderInfos(arg_4_2)
		arg_4_0:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
		arg_4_0:dispatchEvent(ActivityWarmUpEvent.OnInfosReply)
	end
end

function var_0_0.onUpdateSingleOrder(arg_5_0, arg_5_1, arg_5_2)
	if ActivityWarmUpModel.instance:getActId() == arg_5_1 then
		ActivityWarmUpModel.instance:updateSingleOrder(arg_5_2)
		arg_5_0:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
	end
end

function var_0_0.onOrderPush(arg_6_0, arg_6_1, arg_6_2)
	if ActivityWarmUpModel.instance:getActId() == arg_6_1 then
		ActivityWarmUpModel.instance:updateSingleOrder(arg_6_2)
		arg_6_0:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
	end

	local var_6_0 = Activity106Config.instance:getActivityWarmUpOrderCo(arg_6_1, arg_6_2.orderId)

	if var_6_0 and arg_6_2.process >= var_6_0.maxProgress then
		GameFacade.showToast(ToastEnum.WarmUpOrderPush, var_6_0.name, string.format("%s/%s", arg_6_2.process, var_6_0.maxProgress))
	end
end

function var_0_0.focusOrderGame(arg_7_0, arg_7_1)
	logNormal("focusOrderGame")

	arg_7_0._focusActId = ActivityWarmUpModel.instance:getActId()
	arg_7_0._focusOrderId = arg_7_1

	ActivityWarmUpGameController.instance:registerCallback(ActivityWarmUpEvent.NotifyGameClear, arg_7_0.finishOrderGame, arg_7_0)
	ActivityWarmUpGameController.instance:registerCallback(ActivityWarmUpEvent.NotifyGameCancel, arg_7_0.cancelOrderGame, arg_7_0)
end

function var_0_0.cancelOrderGame(arg_8_0)
	logNormal("cancelOrderGame")
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameClear, arg_8_0.finishOrderGame, arg_8_0)
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameCancel, arg_8_0.cancelOrderGame, arg_8_0)

	arg_8_0._focusActId = nil
	arg_8_0._focusOrderId = nil

	arg_8_0:dispatchEvent(ActivityWarmUpEvent.PlayOrderCancel)
end

function var_0_0.finishOrderGame(arg_9_0)
	logNormal("finishOrderGame")
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameClear, arg_9_0.finishOrderGame, arg_9_0)
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameCancel, arg_9_0.cancelOrderGame, arg_9_0)

	if arg_9_0._focusActId ~= nil and arg_9_0._focusOrderId ~= nil then
		Activity106Rpc.instance:sendGet106OrderBonusRequest(arg_9_0._focusActId, arg_9_0._focusOrderId, ActivityWarmUpGameController.instance:getGameCostTime(), arg_9_0.onFinishReceive, arg_9_0)
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity106)
	end
end

function var_0_0.onFinishReceive(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 ~= 0 then
		return
	end

	if arg_10_0._focusActId ~= nil and arg_10_0._focusOrderId ~= nil then
		arg_10_0:dispatchEvent(ActivityWarmUpEvent.PlayOrderFinish, {
			actId = arg_10_0._focusActId,
			orderId = arg_10_0._focusOrderId
		})
	end
end

function var_0_0.getRedDotParam(arg_11_0)
	local var_11_0 = ActivityWarmUpModel.instance:getActId()
	local var_11_1 = ActivityConfig.instance:getActivityCo(var_11_0)

	if var_11_1 then
		local var_11_2 = ActivityConfig.instance:getActivityCenterCo(var_11_1.showCenter)

		if var_11_2 then
			return var_11_2.reddotid, var_11_0
		end
	end

	return nil
end

function var_0_0.cantJumpDungeonGetName(arg_12_0, arg_12_1)
	local var_12_0 = JumpConfig.instance:getJumpConfig(arg_12_1)

	if not var_12_0 then
		return false
	end

	local var_12_1 = var_12_0.param

	if JumpController.instance:cantJump(var_12_1) then
		local var_12_2 = string.split(var_12_1, "#")
		local var_12_3 = tonumber(var_12_2[#var_12_2])
		local var_12_4 = DungeonConfig.instance:getEpisodeCO(var_12_3)
		local var_12_5 = DungeonController.getEpisodeName(var_12_4)

		return true, var_12_5
	end

	return false
end

function var_0_0.switchTab(arg_13_0, arg_13_1)
	ActivityWarmUpModel.instance:selectDayTab(arg_13_1)
	arg_13_0:dispatchEvent(ActivityWarmUpEvent.ViewSwitchTab)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
