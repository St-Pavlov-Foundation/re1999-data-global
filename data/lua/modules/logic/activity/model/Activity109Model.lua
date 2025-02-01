module("modules.logic.activity.model.Activity109Model", package.seeall)

slot0 = class("Activity109Model", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getCurActivityID(slot0)
	return slot0._activity_id
end

function slot0.onReceiveGetAct109InfoReply(slot0, slot1)
	slot0._activity_id = slot1.activityId
	slot0._is_all_clear = true
	slot0._episode_data = {}

	slot0:initChapterClear()

	for slot5, slot6 in ipairs(slot1.episodes) do
		slot7 = slot6.id
		slot0._episode_data[slot7] = {
			id = slot6.id,
			star = slot6.star,
			totalCount = slot6.totalCount
		}
		slot8 = Activity109Config.instance:getEpisodeCo(slot0._activity_id, slot7)

		if slot6.star and slot6.star <= 0 then
			slot0._is_all_clear = false

			if slot8 then
				slot0._episode_clear[slot8.chapterId] = false
			end
		end
	end

	Activity109ChessController.instance:dispatchEvent(ActivityEvent.Refresh109ActivityData)
end

function slot0.initChapterClear(slot0)
	slot0._episode_clear = {}
	slot1, slot2 = Activity109Config.instance:getEpisodeList(slot0._activity_id)

	for slot6, slot7 in ipairs(slot2) do
		slot0._episode_clear[slot7] = true
	end

	slot0._chapter_id_list = slot2
end

function slot0.getEpisodeData(slot0, slot1)
	return slot0._episode_data and slot0._episode_data[slot1]
end

function slot0.getTaskData(slot0, slot1)
	return TaskModel.instance:getTaskById(slot1)
end

function slot0.isAllClear(slot0)
	return slot0._is_all_clear
end

function slot0.isChapterClear(slot0, slot1)
	return slot0._episode_clear[slot1]
end

function slot0.getChapterList(slot0)
	return slot0._chapter_id_list
end

function slot0.increaseCount(slot0, slot1)
	if slot0._episode_data and slot0._episode_data[slot1] then
		slot2.totalCount = slot2.totalCount + 1
	end
end

slot0.instance = slot0.New()

return slot0
