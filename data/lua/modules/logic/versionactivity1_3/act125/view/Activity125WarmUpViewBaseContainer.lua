module("modules.logic.versionactivity1_3.act125.view.Activity125WarmUpViewBaseContainer", package.seeall)

slot0 = class("Activity125WarmUpViewBaseContainer", Activity125ViewBaseContainer)

function slot0.onContainerInit(slot0)
	uv0.super.onContainerInit(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, slot0._onDataUpdate, slot0)
	Activity125Controller.instance:registerCallback(Activity125Event.SwitchEpisode, slot0._onSwitchEpisode, slot0)
end

function slot0.onContainerOpen(slot0)
	uv0.super.onContainerOpen(slot0)
	Activity125Controller.instance:getAct125InfoFromServer(slot0:actId())
end

function slot0.onContainerClose(slot0)
	uv0.super.onContainerClose(slot0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.SwitchEpisode, slot0._onSwitchEpisode, slot0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, slot0._onDataUpdate, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onDataUpdate(slot0)
	slot1 = slot0._isInited

	if not slot0._isInited then
		slot0:onDataUpdateFirst()

		slot0._isInited = true
	end

	slot0:onDataUpdate()

	if slot1 ~= slot0._isInited then
		slot0:onDataUpdateDoneFirst()
	end
end

function slot0._onSwitchEpisode(slot0)
	if not slot0._isInited then
		return
	end

	slot0:onSwitchEpisode()
end

function slot0._onDailyRefresh(slot0)
	Activity125Controller.instance:getAct125InfoFromServer(slot0:actId())
end

function slot0._onCloseViewFinish(slot0, ...)
	if not slot0._isInited then
		return
	end

	slot0:onCloseViewFinish(...)
end

function slot0.actId(slot0)
	return slot0.viewParam.actId
end

function slot0.dispatchRedEvent(slot0)
	Activity125Model.instance:setHasCheckEpisode(slot0:actId(), slot0:getCurSelectedEpisode())
	RedDotController.instance:dispatchEvent(RedDotEvent.RedDotEvent.UpdateActTag)
end

function slot0.onDataUpdateFirst(slot0)
end

function slot0.onDataUpdate(slot0)
	assert(false, "please override this function")
end

function slot0.onDataUpdateDoneFirst(slot0)
end

function slot0.onSwitchEpisode(slot0)
end

function slot0.onCloseViewFinish(slot0, ...)
end

return slot0
