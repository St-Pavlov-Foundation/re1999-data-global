module("modules.logic.versionactivity1_4.act132.model.Activity132Mo", package.seeall)

slot0 = class("Activity132Mo")

function slot0.ctor(slot0, slot1)
	slot0.id = slot1
	slot0.selectCollectId = nil
	slot0.contentStateDict = {}

	slot0:initCfg()
end

function slot0.initCfg(slot0)
	slot0.collectDict = {}

	if Activity132Config.instance:getCollectDict(slot0.id) then
		for slot5, slot6 in pairs(slot1) do
			slot0.collectDict[slot6.collectId] = Activity132CollectMo.New(slot6)
		end
	end
end

function slot0.init(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5 = 1, #slot1.contents do
		slot6 = slot1.contents[slot5]
		slot0.contentStateDict[slot6.Id] = slot6.state
	end
end

function slot0.getCollectList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.collectDict) do
		table.insert(slot1, slot6)
	end

	if #slot1 > 1 then
		table.sort(slot1, SortUtil.keyLower("collectId"))
	end

	return slot1
end

function slot0.getCollectMo(slot0, slot1)
	return slot0.collectDict[slot1]
end

function slot0.getContentState(slot0, slot1)
	return slot0.contentStateDict[slot1] or Activity132Enum.ContentState.Lock
end

function slot0.getSelectCollectId(slot0)
	return slot0.selectCollectId
end

function slot0.setSelectCollectId(slot0, slot1)
	slot0.selectCollectId = slot1
end

function slot0.setContentUnlock(slot0, slot1)
	for slot5 = 1, #slot1 do
		slot0.contentStateDict[slot1[slot5]] = Activity132Enum.ContentState.Unlock
	end
end

function slot0.checkClueRed(slot0, slot1)
	if string.splitToNumber(Activity132Config.instance:getClueConfig(slot0.id, slot1).contents, "#") then
		for slot7, slot8 in ipairs(slot3) do
			if slot0:getContentState(slot8) == Activity132Enum.ContentState.CanUnlock then
				return true
			end
		end
	end
end

return slot0
