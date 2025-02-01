module("modules.logic.versionactivity1_3.act126.controller.Activity126Controller", package.seeall)

slot0 = class("Activity126Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0, LuaEventSystem.Low)
end

function slot0.dailyRefresh(slot0)
	if not Activity126Model.instance.isInit then
		return
	end

	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act310) then
		return
	end

	Activity126Rpc.instance:sendGet126InfosRequest(VersionActivity1_3Enum.ActivityId.Act310)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
