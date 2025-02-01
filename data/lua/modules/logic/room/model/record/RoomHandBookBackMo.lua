module("modules.logic.room.model.record.RoomHandBookBackMo", package.seeall)

slot0 = class("RoomHandBookBackMo")

function slot0.ctor(slot0)
	slot0._config = nil
	slot0.id = nil
	slot0.icon = nil
	slot0._isEmpty = false
	slot0._isNew = false
end

function slot0.init(slot0, slot1)
	slot0._mo = slot1
	slot0.id = slot1.id
	slot0._config = ItemConfig.instance:getItemCo(slot0.id)
	slot0.icon = slot0._config.icon
end

function slot0.getConfig(slot0)
	return slot0._config
end

function slot0.checkNew(slot0)
	return slot0._isNew
end

function slot0.clearNewState(slot0)
	slot0._isNew = false
end

function slot0.isEmpty(slot0)
	return slot0._isEmpty
end

function slot0.setEmpty(slot0)
	slot0._isEmpty = true
	slot0.id = 0
end

function slot0.checkIsUse(slot0)
	if RoomHandBookModel.instance:getSelectMoBackGroundId() and slot1 ~= 0 then
		return slot1 == slot0.id
	elseif slot0._isEmpty then
		return true
	end

	return false
end

return slot0
