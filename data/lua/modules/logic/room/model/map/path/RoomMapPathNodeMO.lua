module("modules.logic.room.model.map.path.RoomMapPathNodeMO", package.seeall)

slot0 = pureTable("RoomMapPathNodeMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.hexPoint = slot2
	slot0.resourceId = slot3
	slot0.resId = slot3
	slot0.directionDic = {}
	slot0.connectNode = {}
	slot0.directionList = {}
	slot0.neighborNum = 0
	slot0.connectNodeNum = 0
	slot0.searchIndex = 0
	slot0.hasBuilding = false
end

function slot0.addDirection(slot0, slot1)
	slot0.directionDic[slot1] = true

	if slot1 >= 1 and slot1 <= 6 and not tabletool.indexOf(slot0.directionList) then
		table.insert(slot0.directionList, slot1)
	end
end

function slot0.getConnectDirection(slot0, slot1)
	return (slot1 + 3 - 1) % 6 + 1
end

function slot0.isHasDirection(slot0, slot1)
	return slot0.directionDic[slot1] ~= nil
end

function slot0.setConnctNode(slot0, slot1, slot2)
	if slot0.directionDic[slot1] ~= nil then
		slot0.connectNode[slot1] = slot2
	end
end

function slot0.getConnctNode(slot0, slot1)
	return slot0.connectNode[slot1]
end

function slot0.getDirectionNum(slot0)
	return #slot0.directionList
end

function slot0.isEndNode(slot0)
	return slot0.connectNodeNum <= 1
end

function slot0.isNotConnctDirection(slot0)
	return slot0.connectNodeNum < #slot0.directionList
end

function slot0.isSideNode(slot0)
	return slot0.neighborNum <= 6
end

return slot0
