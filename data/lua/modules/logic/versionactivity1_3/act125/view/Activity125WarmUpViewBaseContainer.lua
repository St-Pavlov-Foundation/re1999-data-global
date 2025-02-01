module("modules.logic.versionactivity1_3.act125.view.Activity125WarmUpViewBaseContainer", package.seeall)

slot0 = class("Activity125WarmUpViewBaseContainer", BaseViewContainer)

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

slot1 = "Activity125|"

function slot0.getPrefsKeyPrefix(slot0)
	return uv0 .. tostring(slot0:actId())
end

function slot0.saveInt(slot0, slot1, slot2)
	GameUtil.playerPrefsSetNumberByUserId(slot1, slot2)
end

function slot0.getInt(slot0, slot1, slot2)
	return GameUtil.playerPrefsGetNumberByUserId(slot1, slot2)
end

function slot0.actId(slot0)
	return slot0.viewParam.actId
end

function slot0.getActivityRemainTimeStr(slot0)
	return ActivityHelper.getActivityRemainTimeStr(slot0:actId())
end

function slot0.getEpisodeCount(slot0)
	return Activity125Config.instance:getEpisodeCount(slot0:actId())
end

function slot0.hasEpisodeCanCheck(slot0)
	return Activity125Model.instance:hasEpisodeCanCheck(slot0:actId())
end

function slot0.dispatchRedEvent(slot0)
	Activity125Model.instance:setHasCheckEpisode(slot0:actId(), slot0:getCurSelectedEpisode())
	RedDotController.instance:dispatchEvent(RedDotEvent.RedDotEvent.UpdateActTag)
end

function slot0.setCurSelectEpisodeIdSlient(slot0, slot1)
	if slot0:getCurSelectedEpisode() == slot1 then
		return
	end

	slot0:setSelectEpisodeId(slot1)

	if slot1 then
		slot0:setOldEpisode(slot1)
	end
end

function slot0.sendFinishAct125EpisodeRequest(slot0)
	slot1 = slot0:getEpisodeConfigCur()

	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(slot0:actId(), slot1.id, slot1.targetFrequency)
end

function slot0.getCurSelectedEpisode(slot0)
	return Activity125Model.instance:getSelectEpisodeId(slot0:actId())
end

function slot0.setSelectEpisodeId(slot0, slot1)
	return Activity125Model.instance:setSelectEpisodeId(slot0:actId(), slot1)
end

function slot0.getEpisodeConfig(slot0, slot1)
	return Activity125Config.instance:getEpisodeConfig(slot0:actId(), slot1)
end

function slot0.isEpisodeFinished(slot0, slot1)
	return Activity125Model.instance:isEpisodeFinished(slot0:actId(), slot1)
end

function slot0.checkIsOldEpisode(slot0, slot1)
	return Activity125Model.instance:checkIsOldEpisode(slot0:actId(), slot1)
end

function slot0.isFirstCheckEpisode(slot0, slot1)
	return Activity125Model.instance:isFirstCheckEpisode(slot0:actId(), slot1)
end

function slot0.isEpisodeDayOpen(slot0, slot1)
	return Activity125Model.instance:isEpisodeDayOpen(slot0:actId(), slot1)
end

function slot0.isEpisodeUnLock(slot0, slot1)
	return Activity125Model.instance:isEpisodeUnLock(slot0:actId(), slot1)
end

function slot0.setLocalIsPlay(slot0, slot1)
	return Activity125Model.instance:setLocalIsPlay(slot0:actId(), slot1)
end

function slot0.checkLocalIsPlay(slot0, slot1)
	return Activity125Model.instance:checkLocalIsPlay(slot0:actId(), slot1)
end

function slot0.isEpisodeReallyOpen(slot0, slot1)
	return Activity125Model.instance:isEpisodeReallyOpen(slot0:actId(), slot1)
end

function slot0.setOldEpisode(slot0, slot1)
	return Activity125Model.instance:setOldEpisode(slot0:actId(), slot1)
end

function slot0.getFirstRewardEpisode(slot0)
	return Activity125Model.instance:getById(slot0:actId()):getFirstRewardEpisode()
end

function slot0.getRLOC(slot0, slot1)
	return Activity125Model.instance:getById(slot0:actId()):getRLOC(slot1)
end

function slot0.getEpisodeConfigCur(slot0)
	return slot0:getEpisodeConfig(slot0:getCurSelectedEpisode())
end

function slot0.isEpisodeFinishedCur(slot0)
	return slot0:isEpisodeFinished(slot0:getCurSelectedEpisode())
end

function slot0.checkIsOldEpisodeCur(slot0)
	return slot0:checkIsOldEpisode(slot0:getCurSelectedEpisode())
end

function slot0.isFirstCheckEpisodeCur(slot0)
	return slot0:isFirstCheckEpisode(slot0:getCurSelectedEpisode())
end

function slot0.isEpisodeDayOpenCur(slot0)
	return slot0:isEpisodeDayOpen(slot0:getCurSelectedEpisode())
end

function slot0.isEpisodeUnLockCur(slot0)
	return slot0:isEpisodeUnLock(slot0:getCurSelectedEpisode())
end

function slot0.setLocalIsPlayCur(slot0)
	return slot0:setLocalIsPlay(slot0:getCurSelectedEpisode())
end

function slot0.checkLocalIsPlayCur(slot0)
	return slot0:checkLocalIsPlay(slot0:getCurSelectedEpisode())
end

function slot0.getLocalIsPlayCur(slot0)
	return slot0:checkLocalIsPlayCur()
end

function slot0.isEpisodeReallyOpenCur(slot0)
	return slot0:isEpisodeReallyOpen(slot0:getCurSelectedEpisode())
end

function slot0.getRLOCCur(slot0)
	return slot0:getRLOC(slot0:getCurSelectedEpisode())
end

function slot0.setOldEpisodeCur(slot0)
	return slot0:setOldEpisode(slot0:getCurSelectedEpisode())
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
