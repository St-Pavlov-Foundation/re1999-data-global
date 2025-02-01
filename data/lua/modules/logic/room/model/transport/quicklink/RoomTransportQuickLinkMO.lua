module("modules.logic.room.model.transport.quicklink.RoomTransportQuickLinkMO", package.seeall)

slot0 = pureTable("RoomTransportQuickLinkMO")

function slot0.init(slot0)
	slot0._nodeMap = {}
	slot0._nodeList = {}
	slot0._nodePoolList = {}
	slot0._maxSearchIndex = 200

	for slot5, slot6 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
		if RoomTransportHelper.canPathByBlockMO(slot6, true) then
			slot7 = slot0:_popNode()
			slot8 = slot6.hexPoint

			slot7:init(slot8)
			RoomHelper.add2KeyValue(slot0._nodeMap, slot8.x, slot8.y, slot7)
			table.insert(slot0._nodeList, slot7)
		end
	end

	slot0._maxSearchIndex = #slot0._nodeList
end

function slot0.findPath(slot0, slot1, slot2, slot3)
	slot0:_resetNodeParam(slot3)

	for slot8, slot9 in ipairs(RoomMapTransportPathModel.instance:getTransportPathMOList()) do
		if slot9:isLinkFinish() then
			for slot14, slot15 in ipairs(slot9:getHexPointList()) do
				if RoomHelper.get2KeyValue(slot0._nodeMap, slot15.x, slot15.y) then
					slot16.isBlock = true
				end
			end
		end
	end

	for slot9, slot10 in ipairs({
		slot1,
		slot2
	}) do
		if RoomMapTransportPathModel.instance:getSiteHexPointByType(slot10) and RoomHelper.get2KeyValue(slot0._nodeMap, slot11.x, slot11.y) then
			slot12.isBlock = false
		end
	end

	slot0._fromNodeList = {}
	slot0._toNodeList = {}

	slot0:_addNodeList(slot0._fromNodeList, slot1)
	slot0:_addNodeList(slot0._toNodeList, slot2)
	slot0:_searchNode(slot0._toNodeList, 0)
	table.sort(slot0._fromNodeList, uv0._sortFunction)
	slot0:_clearSelectPathFlag()

	return slot0:_findNodePathList(slot0._fromNodeList[1])
end

function slot0._sortFunction(slot0, slot1)
	if uv0._getLinkIdx(slot0) ~= uv0._getLinkIdx(slot1) then
		return slot2 < slot3
	end

	if slot0.searchIndex ~= slot1.searchIndex then
		return slot0.searchIndex < slot1.searchIndex
	end
end

function slot0._getLinkIdx(slot0)
	if slot0.isBlock or slot0.searchIndex == -1 then
		return 10000
	end

	if slot0.linkNum > 1 then
		if slot0.searchIndex == 0 then
			return 2
		end

		return 1
	end

	if slot0.searchIndex == 0 then
		return 100
	end

	return 10
end

function slot0._addNodeList(slot0, slot1, slot2)
	if RoomMapTransportPathModel.instance:getSiteHexPointByType(slot2) and RoomHelper.get2KeyValue(slot0._nodeMap, slot3.x, slot3.y) then
		table.insert(slot1, slot4)

		return
	end

	if RoomMapBuildingAreaModel.instance:getAreaMOByBType(slot2) then
		for slot9, slot10 in ipairs(slot4:getRangesHexPointList()) do
			if RoomHelper.get2KeyValue(slot0._nodeMap, slot10.x, slot10.y) then
				table.insert(slot1, slot11)
			end
		end
	end
end

function slot0._updateNodeListLinkNum(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot6.linkNum = 0

		for slot10 = 1, 6 do
			slot11 = HexPoint.directions[slot10]

			if RoomHelper.get2KeyValue(slot0._nodeMap, slot11.x + slot6.hexPoint.x, slot11.y + slot6.hexPoint.y) and not slot12.isBlock and slot12.searchIndex ~= -1 then
				slot6.linkNum = slot6.linkNum + 1
			end
		end
	end
end

function slot0._resetNodeParam(slot0, slot1)
	for slot6 = 1, #slot0._nodeList do
		slot7 = slot0._nodeList[slot6]

		slot7:resetParam()

		slot7.isBuilding = RoomMapBuildingModel.instance:isHasBuilding(slot7.hexPoint.x, slot7.hexPoint.y)

		if slot1 then
			slot7.isBlock = false
		else
			slot7.isBlock = slot7.isBuilding
		end
	end
end

function slot0._findNodePathList(slot0, slot1, slot2)
	if not slot1 or slot1.isBlock or slot1.searchIndex == -1 then
		return nil
	end

	if slot1.searchIndex == 0 and slot2 and #slot2 > 1 then
		return slot2
	end

	slot3 = nil

	if slot1.searchIndex - 1 < 0 then
		slot4 = 0
	end

	for slot8 = 1, 6 do
		slot9 = HexPoint.directions[slot8]

		if RoomHelper.get2KeyValue(slot0._nodeMap, slot9.x + slot1.hexPoint.x, slot9.y + slot1.hexPoint.y) and slot10.searchIndex == slot4 and slot10.isSelectPath ~= true then
			slot10.isSelectPath = true

			if not slot2 then
				slot1.isSelectPath = true
				slot2 = {
					slot1
				}
			end

			slot3 = slot10

			table.insert(slot2, slot10)

			break
		end
	end

	return slot0:_findNodePathList(slot3, slot2)
end

function slot0._clearSelectPathFlag(slot0)
	for slot4, slot5 in ipairs(slot0._nodeList) do
		slot5.isSelectPath = false
	end
end

function slot0._searchNode(slot0, slot1, slot2)
	if not slot1 or #slot1 < 1 or slot0._maxSearchIndex < slot2 then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if not slot7.isBlock and (slot7.searchIndex == -1 or slot2 < slot7.searchIndex) then
			slot7.searchIndex = slot2
		end
	end

	slot3 = nil
	slot4 = slot2 + 1

	for slot8, slot9 in ipairs(slot1) do
		if not slot9.isBlock and slot9.searchIndex == slot2 then
			for slot13 = 1, 6 do
				slot14 = HexPoint.directions[slot13]

				if RoomHelper.get2KeyValue(slot0._nodeMap, slot14.x + slot9.hexPoint.x, slot14.y + slot9.hexPoint.y) and not slot15.isBlock and (slot15.searchIndex == -1 or slot4 < slot15.searchIndex) then
					slot15.searchIndex = slot4

					table.insert(slot3 or {}, slot15)
				end
			end
		end
	end

	slot0:_searchNode(slot3, slot4)
end

function slot0._popNode(slot0)
	slot1 = nil

	if #slot0._nodePoolList > 0 then
		slot1 = slot0._nodePoolList[slot2]

		table.remove(slot0._nodePoolList, slot2)
	else
		slot1 = RoomTransportNodeMO.New()
	end

	return slot1
end

function slot0._pushNode(slot0, slot1)
	if slot1 then
		table.insert(slot0._nodePoolList, slot1)
	end
end

function slot0.getNodeList(slot0)
	return slot0._nodeList
end

return slot0
