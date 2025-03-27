module("modules.logic.versionactivity1_3.act125.view.Activity125ViewBaseContainer", package.seeall)

slot0 = class("Activity125ViewBaseContainer", BaseViewContainer)
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

function slot0.getActivityRemainTimeStr(slot0)
	return ActivityHelper.getActivityRemainTimeStr(slot0:actId())
end

function slot0.getEpisodeCount(slot0)
	return Activity125Config.instance:getEpisodeCount(slot0:actId())
end

function slot0.hasEpisodeCanCheck(slot0)
	return Activity125Model.instance:hasEpisodeCanCheck(slot0:actId())
end

function slot0.getH5BaseUrl(slot0)
	return Activity125Config.instance:getH5BaseUrl(slot0:actId())
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

function slot0.getEpisodeConfig(slot0, slot1)
	return Activity125Config.instance:getEpisodeConfig(slot0:actId(), slot1)
end

function slot0.setSelectEpisodeId(slot0, slot1)
	return Activity125Model.instance:setSelectEpisodeId(slot0:actId(), slot1)
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

function slot0.sendGetTaskInfoRequest(slot0, slot1, slot2)
	Activity125Controller.instance:sendGetTaskInfoRequest(slot1, slot2)
end

function slot0.sendFinishAllTaskRequest(slot0, slot1, slot2)
	Activity125Controller.instance:sendFinishAllTaskRequest(slot0:actId(), slot1, slot2)
end

function slot0.sendFinishTaskRequest(slot0, slot1, slot2, slot3)
	TaskRpc.instance:sendFinishTaskRequest(slot1, slot2, slot3)
end

function slot0.getTaskCO_sum_help_npc(slot0, slot1)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(slot0:actId(), ActivityWarmUpEnum.Activity125TaskTag.sum_help_npc, slot1)
end

function slot0.getTaskCO_help_npc(slot0, slot1)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(slot0:actId(), ActivityWarmUpEnum.Activity125TaskTag.help_npc, slot1)
end

function slot0.getTaskCO_perfect_win(slot0, slot1)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(slot0:actId(), ActivityWarmUpEnum.Activity125TaskTag.perfect_win, slot1)
end

function slot0.isTimeToActiveH5Btn(slot0)
	if string.nilorempty(CommonConfig.instance:getConstStr(ConstEnum.V2a4_WarmUp_btnplay_openTs)) then
		return true
	end

	return TimeUtil.stringToTimestamp(SettingsModel.instance:extractByRegion(slot1)) <= ServerTime.now()
end

function slot0.actId(slot0)
	assert(false, "please override this function")
end

return slot0
