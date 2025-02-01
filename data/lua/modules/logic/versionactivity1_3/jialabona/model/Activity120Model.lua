module("modules.logic.versionactivity1_3.jialabona.model.Activity120Model", package.seeall)

slot0 = class("Activity120Model", BaseModel)

function slot0.onInit(slot0)
	slot0._curEpisodeId = 0
end

function slot0.reInit(slot0)
	slot0._curEpisodeId = 0
end

function slot0.getCurActivityID(slot0)
	return slot0._curActivityId
end

function slot0.onReceiveGetAct120InfoReply(slot0, slot1)
	slot0._curActivityId = slot1.activityId
	slot0._episodeInfoData = {}

	for slot5, slot6 in ipairs(slot1.episodes) do
		slot7 = slot6.id
		slot0._episodeInfoData[slot7] = {
			id = slot6.id,
			star = slot6.star,
			totalCount = slot6.totalCount
		}
	end
end

function slot0.getEpisodeData(slot0, slot1)
	return slot0._episodeInfoData and slot0._episodeInfoData[slot1]
end

function slot0.isEpisodeClear(slot0, slot1)
	if slot0:getEpisodeData(slot1) then
		return slot2.star > 0
	end

	return false
end

function slot0.getTaskData(slot0, slot1)
	return TaskModel.instance:getTaskById(slot1)
end

function slot0.increaseCount(slot0, slot1)
	if slot0._episodeInfoData and slot0._episodeInfoData[slot1] then
		slot2.totalCount = slot2.totalCount + 1
	end
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId
end

slot0.instance = slot0.New()

return slot0
