module("modules.logic.tower.model.TowerTalentTree", package.seeall)

slot0 = class("TowerTalentTree")

function slot0.ctor(slot0)
end

function slot0.initTree(slot0, slot1, slot2)
	slot0.nodeDict = {}
	slot0.nodeGroupDict = {}
	slot0.rootNode = nil
	slot0.bossMo = slot1
	slot0.talentCount = 0

	if slot2 then
		for slot6, slot7 in pairs(slot2) do
			slot8 = slot0:makeNode(slot7)
			slot0.nodeDict[slot7.nodeId] = slot8

			if slot8:isRootNode() then
				slot0.rootNode = slot8
			end

			if slot7.nodeGroup ~= 0 then
				if slot0.nodeGroupDict[slot7.nodeGroup] == nil then
					slot0.nodeGroupDict[slot7.nodeGroup] = {}
				end

				table.insert(slot0.nodeGroupDict[slot7.nodeGroup], slot7.nodeId)
			end

			slot0.talentCount = slot0.talentCount + 1
		end

		for slot6, slot7 in pairs(slot2) do
			slot0:setNodeParentAndChild(slot7)
		end
	end
end

function slot0.makeNode(slot0, slot1)
	slot2 = TowerTalentTreeNode.New()

	slot2:init(slot1, slot0)

	return slot2
end

function slot0.setNodeParentAndChild(slot0, slot1)
	slot3 = nil

	if (not slot0:getNode(slot1.nodeId).isOr or string.splitToNumber(slot1.preNodeIds, "#")) and string.splitToNumber(slot1.preNodeIds, "&") then
		for slot7, slot8 in pairs(slot3) do
			if slot0:getNode(slot8) then
				slot2:setParent(slot9)
				slot9:setChild(slot2)
			end
		end
	end
end

function slot0.getNode(slot0, slot1)
	return slot0.nodeDict[slot1]
end

function slot0.isActiveTalent(slot0, slot1)
	return slot0.bossMo:isActiveTalent(slot1)
end

function slot0.isActiveGroup(slot0, slot1)
	slot3 = false
	slot4 = nil

	if slot0.nodeGroupDict[slot1] then
		for slot8, slot9 in pairs(slot2) do
			if slot0:isActiveTalent(slot9) then
				slot3 = true
				slot4 = slot9

				break
			end
		end
	end

	return slot3, slot4
end

function slot0.getTalentPoint(slot0)
	return slot0.bossMo:getTalentPoint()
end

function slot0.getList(slot0)
	if not slot0.nodeList then
		slot0.nodeList = {}

		for slot4, slot5 in pairs(slot0.nodeDict) do
			table.insert(slot0.nodeList, slot5)
		end

		if #slot0.nodeList > 1 then
			table.sort(slot0.nodeList, SortUtil.keyLower("nodeId"))
		end
	end

	return slot0.nodeList
end

function slot0.hasTalentCanActive(slot0)
	for slot4, slot5 in pairs(slot0.nodeDict) do
		if slot5:isTalentCanActive() then
			return true
		end
	end

	return false
end

function slot0.getActiveTalentList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isActiveTalent() then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

return slot0
