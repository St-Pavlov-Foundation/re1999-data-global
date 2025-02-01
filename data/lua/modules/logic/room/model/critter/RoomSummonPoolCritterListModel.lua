module("modules.logic.room.model.critter.RoomSummonPoolCritterListModel", package.seeall)

slot0 = class("RoomSummonPoolCritterListModel", ListScrollModel)

function slot0.setDataList(slot0, slot1)
	table.sort(slot1, slot0._sortFunction)
	slot0:setList(slot1)
end

function slot0._sortFunction(slot0, slot1)
	if slot0:getPoolCount() <= 0 ~= (slot1:getPoolCount() <= 0) then
		return slot3
	end

	return slot1.rare < slot0.rare
end

slot0.instance = slot0.New()

return slot0
