module("modules.logic.room.controller.RoomSceneTaskValidator", package.seeall)

slot0 = {
	getRoomSceneTaskStatus = function (slot0)
		if slot0.config and uv0.handleMap[slot1.listenerType] then
			slot4, slot5 = slot3(slot0)

			if slot5 < 0 then
				slot5 = 0
			end

			return slot4, slot5
		end

		return false, 0
	end,
	canGetByLocal = function (slot0)
		if slot0.config and uv0.handleMap[slot1.listenerType] then
			return true
		end

		return false
	end,
	handleTotalBlock = function (slot0)
		slot2 = RoomMapBlockModel.instance:getBackBlockModel()

		for slot7, slot8 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
			if slot8.blockId ~= nil and slot8.blockId < 0 and RoomMapBlockModel.instance:getTempBlockMO() ~= slot8 then
				slot3 = 0 + 1
			end
		end

		if slot2 then
			slot3 = slot3 + slot2:getCount()
		end

		if slot0.config.maxProgress < #slot1 - slot3 then
			slot6 = slot5
		end

		return slot5 <= slot6, slot6
	end,
	handleResBlockCount = function (slot0)
		slot1 = slot0.config
		slot3 = slot1.maxProgress

		for slot9, slot10 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
			if (slot10.blockId ~= nil and slot10.blockId >= 0 or RoomMapBlockModel.instance:getTempBlockMO() == slot10) and uv0.containBlockMOResID(slot10, tonumber(slot1.listenerParam)) then
				slot5 = 0 + 1
			end
		end

		if RoomMapBlockModel.instance:getBackBlockModel() then
			for slot10, slot11 in ipairs(slot6:getList()) do
				if uv0.containBlockMOResID(slot11, slot2) then
					slot5 = slot5 - 1
				end
			end
		end

		if slot3 < slot5 then
			slot5 = slot3
		end

		return slot3 <= slot5, slot5
	end,
	handleSubResBlockCount = function (slot0)
		slot1 = slot0.config
		slot3 = slot1.maxProgress

		for slot9, slot10 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
			if (slot10.blockId ~= nil and slot10.blockId >= 0 or RoomMapBlockModel.instance:getTempBlockMO() == slot10) and uv0.containSubMOResID(slot10, tonumber(slot1.listenerParam)) then
				slot5 = 0 + 1
			end
		end

		if RoomMapBlockModel.instance:getBackBlockModel() then
			for slot10, slot11 in ipairs(slot6:getList()) do
				if uv0.containSubMOResID(slot11, slot2) then
					slot5 = slot5 - 1
				end
			end
		end

		if slot3 < slot5 then
			slot5 = slot3
		end

		return slot3 <= slot5, slot5
	end,
	handleBuildingCount = function (slot0)
		slot2 = slot0.config.maxProgress

		for slot8, slot9 in pairs(uv0.getAllBuildingInMap()) do
			slot3 = 0 + 1
		end

		if slot2 < slot3 then
			slot3 = slot2
		end

		return slot2 <= slot3, slot3
	end,
	handleBuildingPower = function (slot0)
		slot2 = slot0.config.maxProgress

		for slot9, slot10 in pairs(uv0.getAllBuildingInMap()) do
			slot3 = 0 + slot10.config.buildDegree
			slot4 = 0 + 1
		end

		if slot2 < slot3 then
			slot3 = slot2
		end

		return slot2 <= slot3, slot4
	end,
	getAllBuildingInMap = function ()
		slot0 = {
			[slot6.uid] = slot6
		}

		for slot5, slot6 in pairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
			if not (slot6 == RoomMapBuildingModel.instance:getTempBuildingMO() and slot6.use) and slot6.config then
				-- Nothing
			end
		end

		slot2 = {}

		if RoomMapBlockModel.instance:getBackBlockModel() then
			for slot7, slot8 in ipairs(slot3:getList()) do
				slot9 = slot8.hexPoint

				if RoomMapBuildingModel.instance:getBuildingParam(slot9.x, slot9.y) and slot10.buildingUid ~= nil then
					slot0[slot10.buildingUid] = nil
				end
			end
		end

		return slot0
	end,
	containBlockMOResID = function (slot0, slot1)
		return slot0.mainRes == slot1
	end,
	containSubMOResID = function (slot0, slot1)
		for slot6, slot7 in pairs(slot0:getResourceList()) do
			if slot7 == slot1 then
				return true
			end
		end

		return false
	end
}
slot0.handleMap = {
	[RoomSceneTaskEnum.ListenerType.EditResArea] = slot0.handleTotalBlock,
	[RoomSceneTaskEnum.ListenerType.EditResTypeReach] = slot0.handleResBlockCount,
	[RoomSceneTaskEnum.ListenerType.EditHasResBlockCount] = slot0.handleSubResBlockCount,
	[RoomSceneTaskEnum.ListenerType.BuildingUseCount] = slot0.handleBuildingCount,
	[RoomSceneTaskEnum.ListenerType.BuildingDegree] = slot0.handleBuildingPower
}

return slot0
