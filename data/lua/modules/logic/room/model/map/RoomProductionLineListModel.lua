module("modules.logic.room.model.map.RoomProductionLineListModel", package.seeall)

slot0 = class("RoomProductionLineListModel", ListScrollModel)

function slot0.updatePartLines(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(RoomConfig.instance:getProductionPartConfig(slot1).productionLines) do
		table.insert(slot3, RoomProductionModel.instance:getLineMO(slot8))
	end

	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
