module("modules.logic.scene.room.comp.entitymgr.RoomBaseSceneUnitMgr", package.seeall)

slot0 = class("RoomBaseSceneUnitMgr", BaseSceneUnitMgr)

function slot0.addUnit(slot0, slot1)
	if not slot0._tagUnitDict[slot1:getTag()] then
		slot0._tagUnitDict[slot2] = {}
	end

	slot3[slot1.id] = slot1
end

return slot0
