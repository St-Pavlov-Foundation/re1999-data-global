module("modules.logic.activity.controller.warmup.ActivityWarmUpController", package.seeall)

slot0 = class("ActivityWarmUpController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.init(slot0, slot1)
	logNormal("ActivityWarmUpController init actId = " .. tostring(slot1))
	ActivityWarmUpModel.instance:init(slot1)

	if ActivityModel.instance:getActMO(slot1) then
		ActivityWarmUpModel.instance:setStartTime(slot2.startTime)
	end

	slot0:switchTab(ActivityWarmUpModel.instance:getCurrentDay() or 1)
end

function slot0.onReceiveInfos(slot0, slot1, slot2)
	if ActivityWarmUpModel.instance:getActId() == slot1 then
		ActivityWarmUpModel.instance:setServerOrderInfos(slot2)
		slot0:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
		slot0:dispatchEvent(ActivityWarmUpEvent.OnInfosReply)
	end
end

function slot0.onUpdateSingleOrder(slot0, slot1, slot2)
	if ActivityWarmUpModel.instance:getActId() == slot1 then
		ActivityWarmUpModel.instance:updateSingleOrder(slot2)
		slot0:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
	end
end

function slot0.onOrderPush(slot0, slot1, slot2)
	if ActivityWarmUpModel.instance:getActId() == slot1 then
		ActivityWarmUpModel.instance:updateSingleOrder(slot2)
		slot0:dispatchEvent(ActivityWarmUpEvent.InfoReceived)
	end

	if Activity106Config.instance:getActivityWarmUpOrderCo(slot1, slot2.orderId) and slot3.maxProgress <= slot2.process then
		GameFacade.showToast(ToastEnum.WarmUpOrderPush, slot3.name, string.format("%s/%s", slot2.process, slot3.maxProgress))
	end
end

function slot0.focusOrderGame(slot0, slot1)
	logNormal("focusOrderGame")

	slot0._focusActId = ActivityWarmUpModel.instance:getActId()
	slot0._focusOrderId = slot1

	ActivityWarmUpGameController.instance:registerCallback(ActivityWarmUpEvent.NotifyGameClear, slot0.finishOrderGame, slot0)
	ActivityWarmUpGameController.instance:registerCallback(ActivityWarmUpEvent.NotifyGameCancel, slot0.cancelOrderGame, slot0)
end

function slot0.cancelOrderGame(slot0)
	logNormal("cancelOrderGame")
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameClear, slot0.finishOrderGame, slot0)
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameCancel, slot0.cancelOrderGame, slot0)

	slot0._focusActId = nil
	slot0._focusOrderId = nil

	slot0:dispatchEvent(ActivityWarmUpEvent.PlayOrderCancel)
end

function slot0.finishOrderGame(slot0)
	logNormal("finishOrderGame")
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameClear, slot0.finishOrderGame, slot0)
	ActivityWarmUpGameController.instance:unregisterCallback(ActivityWarmUpEvent.NotifyGameCancel, slot0.cancelOrderGame, slot0)

	if slot0._focusActId ~= nil and slot0._focusOrderId ~= nil then
		Activity106Rpc.instance:sendGet106OrderBonusRequest(slot0._focusActId, slot0._focusOrderId, ActivityWarmUpGameController.instance:getGameCostTime(), slot0.onFinishReceive, slot0)
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity106)
	end
end

function slot0.onFinishReceive(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	if slot0._focusActId ~= nil and slot0._focusOrderId ~= nil then
		slot0:dispatchEvent(ActivityWarmUpEvent.PlayOrderFinish, {
			actId = slot0._focusActId,
			orderId = slot0._focusOrderId
		})
	end
end

function slot0.getRedDotParam(slot0)
	if ActivityConfig.instance:getActivityCo(ActivityWarmUpModel.instance:getActId()) and ActivityConfig.instance:getActivityCenterCo(slot2.showCenter) then
		return slot3.reddotid, slot1
	end

	return nil
end

function slot0.cantJumpDungeonGetName(slot0, slot1)
	if not JumpConfig.instance:getJumpConfig(slot1) then
		return false
	end

	if JumpController.instance:cantJump(slot2.param) then
		slot4 = string.split(slot3, "#")

		return true, DungeonController.getEpisodeName(DungeonConfig.instance:getEpisodeCO(tonumber(slot4[#slot4])))
	end

	return false
end

function slot0.switchTab(slot0, slot1)
	ActivityWarmUpModel.instance:selectDayTab(slot1)
	slot0:dispatchEvent(ActivityWarmUpEvent.ViewSwitchTab)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
