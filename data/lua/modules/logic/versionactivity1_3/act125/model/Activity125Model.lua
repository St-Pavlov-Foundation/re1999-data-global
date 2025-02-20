module("modules.logic.versionactivity1_3.act125.model.Activity125Model", package.seeall)

slot0 = class("Activity125Model", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setActivityInfo(slot0, slot1)
	if not slot0:getById(slot1.activityId) then
		slot2 = Activity125MO.New()

		slot2:setInfo(slot1)
		slot0:addAtLast(slot2)
	else
		slot2:setInfo(slot1)
	end
end

function slot0.refreshActivityInfo(slot0, slot1)
	if not slot0:getById(slot1.activityId) then
		return
	end

	slot2:updateInfo(slot1.updateAct125Episodes)
end

function slot0.isEpisodeFinished(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:isEpisodeFinished(slot2)
end

function slot0.isEpisodeUnLock(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:isEpisodeUnLock(slot2)
end

function slot0.isEpisodeDayOpen(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:isEpisodeDayOpen(slot2)
end

function slot0.isEpisodeReallyOpen(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:isEpisodeReallyOpen(slot2)
end

function slot0.getLastEpisode(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	return slot2:getLastEpisode()
end

function slot0.setLocalIsPlay(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	slot3:setLocalIsPlay(slot2)
end

function slot0.checkLocalIsPlay(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:checkLocalIsPlay(slot2)
end

function slot0.getEpisodeCount(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	return slot2:getEpisodeCount()
end

function slot0.getEpisodeList(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	return slot2:getEpisodeList()
end

function slot0.getEpisodeConfig(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:getEpisodeConfig(slot2)
end

function slot0.setSelectEpisodeId(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:setSelectEpisodeId(slot2)
end

function slot0.getSelectEpisodeId(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	return slot2:getSelectEpisodeId()
end

function slot0.setOldEpisode(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	slot3:setOldEpisode(slot2)
end

function slot0.checkIsOldEpisode(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:checkIsOldEpisode(slot2)
end

function slot0.isAllEpisodeFinish(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	return slot2:isAllEpisodeFinish()
end

function slot0.isHasEpisodeCanReceiveReward(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:isHasEpisodeCanReceiveReward(slot2)
end

function slot0.isFirstCheckEpisode(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:isFirstCheckEpisode(slot2)
end

function slot0.setHasCheckEpisode(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	return slot3:setHasCheckEpisode(slot2)
end

function slot0.hasEpisodeCanCheck(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	return slot2:hasEpisodeCanCheck()
end

function slot0.hasEpisodeCanGetReward(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	return slot2:hasEpisodeCanGetReward()
end

function slot0.hasRedDot(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	return slot2:hasRedDot()
end

function slot0.isActivityOpen(slot0, slot1)
	if ActivityModel.instance:isActOnLine(slot1) == false then
		return false
	end

	return ActivityModel.instance:getActMO(slot1):isOpen() and not slot2:isExpired()
end

slot0.instance = slot0.New()

return slot0
