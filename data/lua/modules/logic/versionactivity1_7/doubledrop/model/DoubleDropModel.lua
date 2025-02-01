module("modules.logic.versionactivity1_7.doubledrop.model.DoubleDropModel", package.seeall)

slot0 = class("DoubleDropModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.act153Dict = {}
end

function slot0.getActId(slot0)
	return ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.DoubleDrop) and slot1[1]
end

function slot0.setActivity153Infos(slot0, slot1)
	slot0:updateActivity153Info(slot1)
	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshDoubleDropInfo)
end

function slot0.updateActivity153Info(slot0, slot1)
	if not slot0:getById(slot1.activityId) then
		slot2 = DoubleDropMo.New()

		slot2:init(slot1)
		slot0:addAtLast(slot2)
	else
		slot2:init(slot1)
	end
end

function slot0.isShowDoubleByChapter(slot0, slot1, slot2)
	if not slot0:getActId() or not ActivityModel.instance:isActOnLine(slot3) then
		return false
	end

	if not DoubleDropConfig.instance:getAct153ActEpisodes(slot3) then
		return false
	end

	slot5 = false

	for slot9, slot10 in pairs(slot4) do
		if DungeonConfig.instance:getEpisodeCO(slot10.episodeId) and slot11.chapterId == slot1 then
			slot5 = true

			break
		end
	end

	if slot5 then
		if not slot2 and DungeonConfig.instance:getChapterCO(slot1).enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(slot6.type) > 0 then
			return false
		end

		slot6, slot7, slot8 = slot0:isDoubleTimesout()

		return not slot6, slot7, slot8
	end

	return false
end

function slot0.isShowDoubleByEpisode(slot0, slot1, slot2)
	if not slot0:getActId() or not ActivityModel.instance:isActOnLine(slot3) then
		return false
	end

	if not DoubleDropConfig.instance:getAct153ActEpisodes(slot3) then
		return false
	end

	slot5 = false

	for slot9, slot10 in pairs(slot4) do
		if slot10.episodeId == slot1 then
			slot5 = true

			break
		end
	end

	if slot5 then
		if not slot2 and DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot1).chapterId).enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(slot7.type) > 0 then
			return false
		end

		slot6, slot7, slot8 = slot0:isDoubleTimesout()

		return not slot6, slot7, slot8
	end

	return false
end

function slot0.isDoubleTimesout(slot0)
	if not slot0:getActId() or not ActivityModel.instance:isActOnLine(slot1) then
		return true
	end

	if not slot0:getById(slot1) then
		return true
	end

	return slot2:isDoubleTimesout()
end

function slot0.getDailyRemainTimes(slot0)
	if not slot0:getActId() then
		return
	end

	if not slot0:getById(slot1) then
		slot4 = DoubleDropConfig.instance:getAct153Co(slot1) and slot3.dailyLimit or 0

		return slot4, slot4
	end

	return slot2:getDailyRemainTimes()
end

slot0.instance = slot0.New()

return slot0
