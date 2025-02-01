module("modules.logic.versionactivity.model.VersionActivity112Model", package.seeall)

slot0 = class("VersionActivity112Model", BaseModel)

function slot0.onInit(slot0)
	slot0.infosDic = {}
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.updateInfo(slot0, slot1)
	slot0._lastActId = slot1.activityId
	slot0.infosDic[slot1.activityId] = {}

	for slot5, slot6 in ipairs(slot1.infos) do
		slot0.infosDic[slot1.activityId][slot6.id] = slot6
	end

	VersionActivity112TaskListModel.instance:refreshAlllTaskInfo(slot1.activityId, slot1.act112Tasks)
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112Update)
end

function slot0.updateRewardState(slot0, slot1, slot2)
	slot0.infosDic[slot1][slot2].state = 1

	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112Update)
end

function slot0.getRewardState(slot0, slot1, slot2)
	if slot0.infosDic[slot1] and slot0.infosDic[slot1][slot2] then
		return slot0.infosDic[slot1][slot2].state
	end

	return 0
end

function slot0.hasGetReward(slot0, slot1, slot2)
	if slot0.infosDic[slot2 or slot0._lastActId] and slot0.infosDic[slot2][slot1] then
		return slot0.infosDic[slot2][slot1].state == 1
	end

	return false
end

function slot0.getRewardList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(VersionActivityConfig.instance:getAct112Config(slot1 or slot0._lastActId)) do
		table.insert(slot3, slot8)
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
