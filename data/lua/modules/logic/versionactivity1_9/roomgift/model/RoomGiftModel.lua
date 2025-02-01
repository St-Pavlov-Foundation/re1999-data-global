module("modules.logic.versionactivity1_9.roomgift.model.RoomGiftModel", package.seeall)

slot0 = class("RoomGiftModel", BaseModel)

function slot0.onInit(slot0)
	slot0:setActivityInfo()
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getActId(slot0)
	return ActivityEnum.Activity.RoomGift
end

function slot0.setActivityInfo(slot0, slot1)
	slot2 = slot1 or {}

	slot0:setCurDay(slot2.currentDay)
	slot0:setHasGotBonus(slot2.hasGetBonus)
end

function slot0.setCurDay(slot0, slot1)
	slot0._curDay = slot1
end

function slot0.setHasGotBonus(slot0, slot1)
	slot0._hasGotBonus = slot1
end

function slot0.getHasGotBonus(slot0)
	return slot0._hasGotBonus
end

function slot0.isActOnLine(slot0, slot1)
	slot2 = false
	slot4, slot5, slot6 = ActivityHelper.getActivityStatusAndToast(slot0:getActId(), true)

	if slot4 == ActivityEnum.ActivityStatus.Normal then
		slot2 = true
	elseif slot1 and slot5 then
		GameFacade.showToastWithTableParam(slot5, slot6)
	end

	return slot2
end

function slot0.isCanGetBonus(slot0)
	slot1 = false

	if slot0:isActOnLine() and RoomGiftConfig.instance:getRoomGiftBonus(slot0:getActId(), slot0._curDay) and slot0:getHasGotBonus() ~= nil then
		slot1 = not slot5
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
