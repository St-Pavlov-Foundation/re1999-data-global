module("modules.logic.investigate.model.InvestigateOpinionModel", package.seeall)

slot0 = class("InvestigateOpinionModel", BaseModel)

function slot0.onInit(slot0)
	slot0._isInitOpinionInfo = false
	slot0._connectedId = {}
	slot0._unLockedId = {}
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getIsInitOpinionInfo(slot0)
	return slot0._isInitOpinionInfo
end

function slot0.initOpinionInfo(slot0, slot1)
	slot0._isInitOpinionInfo = true

	for slot5, slot6 in ipairs(slot1.intelBox) do
		for slot10, slot11 in ipairs(slot6.clueIds) do
			slot0._connectedId[slot11] = slot11
		end
	end

	for slot5, slot6 in ipairs(slot1.clueIds) do
		slot0._unLockedId[slot6] = slot6
	end
end

function slot0.isUnlocked(slot0, slot1)
	return slot0._unLockedId[slot1] ~= nil
end

function slot0.setInfo(slot0, slot1, slot2)
	slot0._mo = slot1
	slot0._moList = slot2
end

function slot0.getInfo(slot0)
	return slot0._mo, slot0._moList
end

function slot0.getLinkedStatus(slot0, slot1)
	return slot0._connectedId[slot1] ~= nil
end

function slot0.setLinkedStatus(slot0, slot1, slot2)
	slot0._connectedId[slot1] = slot2
end

function slot0.allOpinionLinked(slot0, slot1)
	for slot6, slot7 in ipairs(InvestigateConfig.instance:getInvestigateAllClueInfos(slot1)) do
		if not slot0:getLinkedStatus(slot7.id) then
			return false
		end
	end

	return true
end

slot0.instance = slot0.New()

return slot0
