module("modules.logic.versionactivity2_0.dungeon.model.Activity161Model", package.seeall)

slot0 = class("Activity161Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.graffitiInfoMap = {}
	slot0.curHasGetRewardMap = {}
	slot0.curActId = 0
	slot0.isNeedRefreshNewElement = false
end

function slot0.getActId(slot0)
	return VersionActivity2_0Enum.ActivityId.DungeonGraffiti
end

function slot0.setGraffitiInfo(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.graffitiInfos or {}) do
		if Activity161Config.instance:getGraffitiCo(slot1.activityId, slot7.id) then
			if not slot0.graffitiInfoMap[slot7.id] then
				slot9 = Activity161MO.New()

				slot9:init(slot7, slot8)

				slot0.graffitiInfoMap[slot7.id] = slot9
			else
				slot9:updateInfo(slot7)
			end
		end
	end

	slot0:setHasGetRewardInfo(slot1)
end

function slot0.setHasGetRewardInfo(slot0, slot1)
	if GameUtil.getTabLen(slot0.curHasGetRewardMap) == 0 then
		for slot6, slot7 in pairs(Activity161Config.instance:getAllRewardCos(slot1.activityId)) do
			slot0.curHasGetRewardMap[slot7.rewardId] = false
		end
	end

	for slot6, slot7 in ipairs(slot1.gainedRewardIds or {}) do
		slot0.curHasGetRewardMap[slot7] = true
	end
end

function slot0.getFinalRewardHasGetState(slot0)
	if #slot0.curHasGetRewardMap > 0 then
		return slot0.curHasGetRewardMap[#slot0.curHasGetRewardMap]
	end

	return false
end

function slot0.getCurPaintedNum(slot0)
	for slot5, slot6 in pairs(slot0.graffitiInfoMap) do
		if slot6.state == Activity161Enum.graffitiState.IsFinished then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.setRewardInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.rewardIds) do
		slot0.curHasGetRewardMap[slot6] = true
	end
end

function slot0.getItemsByState(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0.graffitiInfoMap) do
		if slot7.state == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getInCdGraffiti(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.graffitiInfoMap) do
		slot7 = Activity161Config.instance:getGraffitiCo(slot0:getActId(), slot6.id)

		if slot7.mainElementCd > 0 and slot6:isInCdTime() and Activity161Config.instance:isPreMainElementFinish(slot7) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getArriveCdGraffitiList(slot0, slot1, slot2)
	slot3 = tabletool.copy(slot1)
	slot4 = {
		[slot9.id] = true
	}

	for slot8, slot9 in pairs(slot2) do
		-- Nothing
	end

	for slot8 = #slot3, 1, -1 do
		if slot4[slot3[slot8].id] then
			table.remove(slot3, slot8)
		end
	end

	return slot3
end

function slot0.setNeedRefreshNewElementsState(slot0, slot1)
	slot0.isNeedRefreshNewElement = slot1
end

function slot0.setGraffitiState(slot0, slot1, slot2)
	if slot0.graffitiInfoMap[slot1] then
		slot3.state = slot2
	else
		logError("graffitiMO is not exit, graffitiId: " .. slot1)
	end
end

function slot0.isUnlockState(slot0, slot1)
	if slot1.state == Activity161Enum.graffitiState.Normal or slot1.state == Activity161Enum.graffitiState.IsFinished then
		return 1
	else
		return 0
	end
end

function slot0.ishaveUnGetReward(slot0)
	slot8 = slot0
	slot4 = {}

	for slot8, slot9 in ipairs(Activity161Config.instance:getAllRewardCos(slot0.getActId(slot8))) do
		if not slot0.curHasGetRewardMap[slot9.rewardId] and slot9.paintedNum <= slot0:getCurPaintedNum() then
			table.insert(slot4, slot9)
		end
	end

	if #slot4 > 0 then
		return true, slot4
	end

	return false
end

slot0.instance = slot0.New()

return slot0
