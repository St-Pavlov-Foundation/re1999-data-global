module("modules.logic.room.model.record.RoomHandBookModel", package.seeall)

slot0 = class("RoomHandBookModel", BaseModel)

function slot0.onInit(slot0)
	slot0._moList = nil
	slot0._selectMo = nil
	slot0._isreverse = false
end

function slot0.getSelectMo(slot0)
	return slot0._selectMo
end

function slot0.setSelectMo(slot0, slot1)
	slot0._selectMo = slot1
end

function slot0.checkCritterShowMutateBtn(slot0, slot1)
end

function slot0.checkCritterRelationShip(slot0)
end

function slot0.onGetInfo(slot0, slot1)
	slot0._moList = slot1.bookInfos
	slot0._moDict = {}

	for slot5, slot6 in ipairs(slot0._moList) do
		slot0._moDict[slot6.id] = slot6
	end
end

function slot0.getMoById(slot0, slot1)
	return slot0._moDict and slot0._moDict[slot1]
end

function slot0.getCount(slot0)
	return slot0._moList and #slot0._moList or 0
end

function slot0.setScrollReverse(slot0)
	slot0._isreverse = not slot0._isreverse

	RoomHandBookListModel.instance:reverseCardBack(slot0._isreverse)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.reverseIcon)
end

function slot0.getReverse(slot0)
	return slot0._isreverse
end

function slot0.getSelectMoBackGroundId(slot0)
	if slot0._selectMo and slot0._selectMo:getBackGroundId() then
		return slot0._selectMo:getBackGroundId()
	end
end

function slot0.setBackGroundId(slot0, slot1)
	slot2 = slot1.id

	if slot0._selectMo then
		slot0._selectMo:setBackGroundId(slot1.backgroundId)
	end
end

slot0.instance = slot0.New()

return slot0
