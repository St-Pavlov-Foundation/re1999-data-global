module("modules.logic.seasonver.act123.model.Season123EpisodeRewardModel", package.seeall)

slot0 = class("Season123EpisodeRewardModel", BaseModel)

function slot0.init(slot0, slot1, slot2)
	slot0.stageRewardMap = {}
	slot0.curActId = slot1

	slot0:initStageRewardConfig(slot2)
end

function slot0.release(slot0)
	slot0:clear()

	slot0.stageRewardMap = {}
	slot0.curActId = 0
end

function slot0.initStageRewardConfig(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot6.config and slot6.config.seasonId == slot0.curActId and slot6.config.isRewardView == Activity123Enum.TaskRewardViewType then
			slot9 = slot0.stageRewardMap[tonumber(Season123Config.instance:getTaskListenerParamCache(slot6.config)[1])] or {}
			slot9[slot5] = slot6
			slot0.stageRewardMap[slot8] = slot9
		end
	end
end

function slot0.setTaskInfoList(slot0, slot1)
	slot2 = {}

	if GameUtil.getTabLen(slot0.stageRewardMap[slot1] or {}) == 0 then
		logError("task_activity123 config is not exited, actid: " .. slot0.curActId .. ",stageId: " .. slot1)
	end

	for slot7, slot8 in pairs(slot3) do
		table.insert(slot2, slot8)
	end

	slot0:setList(slot2)
	slot0:sort(uv0.sortList)
end

function slot0.sortList(slot0, slot1)
	return tonumber(string.split(slot1.config.listenerParam, "#")[2]) < tonumber(string.split(slot0.config.listenerParam, "#")[2])
end

function slot0.getCurStageCanGetReward(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.config.maxProgress <= slot7.progress and slot7.hasFinished then
			table.insert(slot1, slot7.id)
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
