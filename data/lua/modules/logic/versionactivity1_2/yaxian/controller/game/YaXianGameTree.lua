module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianGameTree", package.seeall)

slot0 = class("YaXianGameTree")
slot0.MaxBucket = 16

function slot0.buildTree(slot0, slot1)
	slot0.allNodes = {}
	slot2 = 50
	slot3 = {
		slot1
	}
	slot4 = 1

	while #slot3 > 0 and slot4 <= slot2 do
		if slot2 < slot4 + 1 then
			logError("max exclusive !")

			break
		end

		slot5 = table.remove(slot3)
		slot9 = slot5

		table.insert(slot0.allNodes, slot9)

		for slot9, slot10 in pairs(slot5.nodes) do
			slot0:processChildNode(slot5, slot10, slot10.x, slot10.y)
			slot0:processChildNode(slot5, slot10, slot10.x - YaXianGameEnum.ClickRangeX, slot10.y)
			slot0:processChildNode(slot5, slot10, slot10.x + YaXianGameEnum.ClickRangeX, slot10.y)
			slot0:processChildNode(slot5, slot10, slot10.x, slot10.y - YaXianGameEnum.ClickRangeY)
			slot0:processChildNode(slot5, slot10, slot10.x, slot10.y + YaXianGameEnum.ClickRangeY)
		end

		for slot9 = 1, 4 do
			if uv0.MaxBucket < #slot5.children[slot9].nodes then
				slot0:growToBranch(slot10)
				table.insert(slot3, slot10)
			end
		end
	end

	logNormal("build tree in " .. tostring(slot4))

	slot0.root = slot1
end

function slot0.processChildNode(slot0, slot1, slot2, slot3, slot4)
	if not slot0:getFixNode(slot1, slot3, slot4).keys[slot2] then
		table.insert(slot5.nodes, slot2)
		table.insert(slot5.centerNodes, slot2)

		slot5.keys[slot2] = true
	end
end

function slot0.createLeaveNode(slot0)
	return {
		nodes = {},
		keys = {},
		centerNodes = {}
	}
end

function slot0.growToBranch(slot0, slot1)
	for slot9, slot10 in pairs(slot1.centerNodes) do
		slot2 = math.min(9999, slot10.x)
		slot3 = math.min(9999, slot10.y)
		slot4 = math.max(-9999, slot10.x)
		slot5 = math.max(-9999, slot10.y)
	end

	slot1.x = (slot2 + slot4) * 0.5
	slot1.y = (slot3 + slot5) * 0.5
	slot1.children = {}

	for slot9 = 1, 4 do
		slot1.children[slot9] = slot0:createLeaveNode()
		slot1.children[slot9].parent = slot1
	end
end

function slot0.getFixNode(slot0, slot1, slot2, slot3)
	if slot1.x < slot2 then
		if slot1.y < slot3 then
			return slot1.children[1]
		else
			return slot1.children[4]
		end
	elseif slot1.y < slot3 then
		return slot1.children[2]
	else
		return slot1.children[3]
	end
end

function slot0.search(slot0, slot1, slot2)
	slot3 = slot0.root

	while slot3.children ~= nil do
		slot3 = slot0:getFixNode(slot3, slot1, slot2)
	end

	if slot3.parent ~= nil then
		return slot4.nodes
	else
		return slot3.nodes
	end
end

return slot0
