module("modules.logic.room.model.map.path.RoomMapPathPlanModel", package.seeall)

slot0 = class("RoomMapPathPlanModel", BaseModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
end

function slot0.init(slot0)
	slot0:clear()
end

function slot0.initPath(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(RoomConfig.instance:getVehicleConfigList()) do
		table.insert(slot1, slot7.resId)
	end

	slot4 = {}

	for slot8, slot9 in pairs(RoomResourceHelper.getResourcePointAreaMODict(nil, slot1)) do
		for slot14, slot15 in ipairs(slot9:findeArea()) do
			slot17 = RoomMapPathPlanMO.New()

			slot17:init(slot8 * 1000 + slot14, slot8, slot15)
			table.insert(slot4, slot17)
		end
	end

	slot0:setList(slot4)
end

function slot0.getPlanMOByXY(slot0, slot1, slot2, slot3)
	for slot8 = 1, #slot0:getList() do
		if slot4[slot8].resourceId == slot3 and slot9:getNodeByXY(slot1, slot2) then
			return slot9
		end
	end
end

slot0.instance = slot0.New()

return slot0
