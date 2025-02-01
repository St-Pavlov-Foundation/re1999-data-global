module("modules.logic.dungeon.model.DungeonMonsterListModel", package.seeall)

slot0 = class("DungeonMonsterListModel", ListScrollModel)

function slot0.setMonsterList(slot0, slot1)
	for slot6, slot7 in ipairs(DungeonModel.instance:getMonsterDisplayList(slot1)) do
		slot2[slot6] = {
			config = slot7
		}
	end

	slot0:setList(slot2)

	slot0.initSelectMO = slot2[1]
end

slot0.instance = slot0.New()

return slot0
