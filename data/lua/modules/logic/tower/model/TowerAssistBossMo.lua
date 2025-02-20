module("modules.logic.tower.model.TowerAssistBossMo", package.seeall)

slot0 = pureTable("TowerAssistBossMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.level = 0
	slot0.talentPoint = 0
end

function slot0.onTowerActiveTalent(slot0, slot1)
	slot0:addTalentId(slot1.talentId)

	slot0.talentPoint = slot1.talentPoint
end

function slot0.onTowerResetTalent(slot0, slot1)
	slot0.talentPoint = slot1.talentPoint

	if slot1.talentId == 0 then
		slot0:initTalentIds()
	else
		slot0:removeTalentId(slot1.talentId)
	end
end

function slot0.updateInfo(slot0, slot1)
	slot0.level = slot1.level
	slot0.talentPoint = slot1.talentPoint

	slot0:initTalentIds(slot1.talentIds)
end

function slot0.initTalentIds(slot0, slot1)
	slot0.talentIdDict = {}
	slot0.talentIdList = {}
	slot0.talentIdCount = 0

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0:addTalentId(slot1[slot5])
		end
	end
end

function slot0.addTalentId(slot0, slot1)
	if not slot1 or slot0:isActiveTalent(slot1) then
		return
	end

	slot0.talentIdCount = slot0.talentIdCount + 1
	slot0.talentIdDict[slot1] = 1
	slot0.talentIdList[slot0.talentIdCount] = slot1
end

function slot0.removeTalentId(slot0, slot1)
	if not slot1 or not slot0:isActiveTalent(slot1) then
		return
	end

	slot0.talentIdCount = slot0.talentIdCount - 1
	slot0.talentIdDict[slot1] = nil

	tabletool.removeValue(slot0.talentIdList, slot1)
end

function slot0.isActiveTalent(slot0, slot1)
	return slot0.talentIdDict[slot1] ~= nil
end

function slot0.getTalentPoint(slot0)
	return slot0.talentPoint
end

function slot0.getTalentTree(slot0)
	if not slot0.talentTree then
		slot0.talentTree = TowerTalentTree.New()

		slot0.talentTree:initTree(slot0, TowerConfig.instance:getAssistTalentConfig().configDict[slot0.id])
	end

	return slot0.talentTree
end

function slot0.getTalentActiveCount(slot0)
	return slot0.talentIdCount, slot0.talentPoint
end

function slot0.hasTalentCanActive(slot0)
	return slot0:getTalentTree():hasTalentCanActive()
end

return slot0
