module("modules.logic.room.model.record.RoomHandBookMo", package.seeall)

slot0 = class("RoomHandBookMo")

function slot0.ctor(slot0)
	slot0._config = nil
	slot0.id = nil
end

function slot0.init(slot0, slot1)
	slot0._config = slot1
	slot0.id = slot1.id
	slot0._isreverse = false
	slot0._mo = RoomHandBookModel.instance:getMoById(slot0.id)
end

function slot0.getConfig(slot0)
	return slot0._config
end

function slot0.checkGotCritter(slot0)
	return slot0._mo and true or false
end

function slot0.getBackGroundId(slot0)
	if slot0._mo and slot0._mo.Background ~= 0 then
		return slot0._mo.Background
	end
end

function slot0.setBackGroundId(slot0, slot1)
	slot0._mo.Background = slot1
end

function slot0.checkUnlockSpeicalSkinById(slot0)
	if not slot0._mo then
		return
	end

	return slot0._mo.unlockSpecialSkin
end

function slot0.setSpeicalSkin(slot0, slot1)
	slot0._mo.UseSpecialSkin = slot1
end

function slot0.checkNew(slot0)
	if not slot0._mo then
		return
	end

	return slot0._mo.isNew
end

function slot0.clearNewState(slot0)
	slot0._mo.isNew = false
end

function slot0.setReverse(slot0, slot1)
	slot0._isreverse = slot1
end

function slot0.checkIsReverse(slot0)
	return slot0._isreverse
end

function slot0.checkShowMutate(slot0)
	if not slot0._mo then
		return false
	end

	return slot0._mo.unlockSpecialSkin and slot0._mo.unlockNormalSkin
end

function slot0.checkShowSpeicalSkin(slot0)
	if not slot0._mo then
		return false
	end

	return slot0._mo.UseSpecialSkin
end

return slot0
