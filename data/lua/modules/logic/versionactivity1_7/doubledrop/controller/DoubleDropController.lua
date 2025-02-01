module("modules.logic.versionactivity1_7.doubledrop.controller.DoubleDropController", package.seeall)

slot0 = class("DoubleDropController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
end

function slot0._checkActivityInfo(slot0, slot1)
	if DoubleDropModel.instance:getActId() and not slot1 or slot1 == slot2 then
		if ActivityModel.instance:isActOnLine(slot2) then
			Activity153Rpc.instance:sendGet153InfosRequest(slot2)
		else
			ActivityController.instance:dispatchEvent(ActivityEvent.RefreshDoubleDropInfo)
		end
	end
end

function slot0.dailyRefresh(slot0)
	if DoubleDropModel.instance:getActId() and ActivityModel.instance:isActOnLine(slot1) then
		Activity153Rpc.instance:sendGet153InfosRequest(slot1)
	end
end

slot0.instance = slot0.New()

return slot0
