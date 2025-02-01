module("modules.logic.room.model.record.RoomHandBookListModel", package.seeall)

slot0 = class("RoomHandBookListModel", ListScrollModel)

function slot0.init(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(lua_critter.configList) do
		slot8 = RoomHandBookMo.New()

		slot8:init(slot7)
		table.insert(slot1, slot8)
	end

	table.sort(slot1, uv0.sort)
	slot0:setList(slot1)
	RoomHandBookModel.instance:setSelectMo(slot1[1])
end

function slot0.sort(slot0, slot1)
	if (slot0:checkGotCritter() and 2 or 1) ~= (slot1:checkGotCritter() and 2 or 1) then
		return slot3 < slot2
	else
		return slot0.id < slot1.id
	end
end

function slot0.reverseCardBack(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		slot7:setReverse(slot1)
	end
end

function slot0.clearItemNewState(slot0, slot1)
	slot0:getById(slot1):clearNewState()
	slot0:onModelUpdate()
end

function slot0.setMutate(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:getById(slot1.id):setSpeicalSkin(slot1.UseSpecialSkin)
end

slot0.instance = slot0.New()

return slot0
