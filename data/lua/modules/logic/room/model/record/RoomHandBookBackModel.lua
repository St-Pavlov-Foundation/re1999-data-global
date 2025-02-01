module("modules.logic.room.model.record.RoomHandBookBackModel", package.seeall)

slot0 = class("RoomHandBookBackModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.getSelectMo(slot0)
	return slot0._selectMo
end

function slot0.setSelectMo(slot0, slot1)
	slot0._selectMo = slot1
end

slot0.instance = slot0.New()

return slot0
