module("modules.logic.tower.model.TowerTalentTreeNode", package.seeall)

slot0 = class("TowerTalentTreeNode")

function slot0.ctor(slot0)
	slot0.parents = {}
	slot0.childs = {}
end

function slot0.init(slot0, slot1, slot2)
	slot0.tree = slot2
	slot0.nodeId = slot1.nodeId
	slot0.id = slot0.nodeId
	slot0.config = slot1
	slot0.isOr = not string.find(slot1.preNodeIds, "&")
end

function slot0.isRootNode(slot0)
	return slot0.config.startNode == 1
end

function slot0.setParent(slot0, slot1)
	slot0.parents[slot1.nodeId] = slot1
end

function slot0.getParents(slot0)
	return slot0.parents
end

function slot0.setChild(slot0, slot1)
	slot0.childs[slot1.nodeId] = slot1
end

function slot0.isActiveTalent(slot0)
	return slot0.tree:isActiveTalent(slot0.nodeId)
end

function slot0.isParentActive(slot0)
	slot1 = nil

	if slot0.isOr then
		for slot5, slot6 in pairs(slot0.parents) do
			if slot6:isActiveTalent() then
				slot1 = true

				break
			else
				slot1 = false
			end
		end
	else
		for slot5, slot6 in pairs(slot0.parents) do
			if not slot6:isActiveTalent() then
				slot1 = false

				break
			end
		end
	end

	if slot1 == nil then
		slot1 = true
	end

	return slot1
end

function slot0.getParentActiveResult(slot0)
	slot1 = 2

	if slot0.isOr then
		for slot5, slot6 in pairs(slot0.parents) do
			if slot6:isActiveTalent() then
				slot1 = 2

				break
			else
				slot1 = 0
			end
		end
	else
		slot2 = 0

		for slot7, slot8 in pairs(slot0.parents) do
			if slot8:isActiveTalent() then
				slot3 = 0 + 1
			end

			slot2 = slot2 + 1
		end

		if slot2 > 0 then
			slot1 = slot2 <= slot3 and 2 or slot3 == 0 and 0 or 1
		end
	end

	return slot1
end

function slot0.isTalentCanActive(slot0)
	return slot0:isParentActive() and slot0:isTalentConsumeEnough()
end

function slot0.isTalentConsumeEnough(slot0)
	return slot0.config.consume <= slot0.tree:getTalentPoint()
end

function slot0.isActiveGroup(slot0)
	return slot0.tree:isActiveGroup(slot0.config.nodeGroup)
end

function slot0.isLeafNode(slot0)
	for slot4, slot5 in pairs(slot0.childs) do
		if slot5:isActiveTalent() then
			return false
		end
	end

	return true
end

return slot0
