module("modules.logic.dragonboat.model.DragonBoatFestivalModel", package.seeall)

slot0 = class("DragonBoatFestivalModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._curDay = nil
end

function slot0.hasRewardNotGet(slot0)
	for slot6, slot7 in pairs(ActivityConfig.instance:getNorSignActivityCos(ActivityEnum.Activity.DragonBoatFestival)) do
		if slot0:isGiftUnlock(slot7.id) and not slot0:isGiftGet(slot7.id) then
			return true
		end
	end

	return false
end

function slot0.setCurDay(slot0, slot1)
	slot0._curDay = slot1
end

function slot0.getCurDay(slot0)
	slot1 = slot0._curDay or slot0:getFinalGiftGetDay()

	return slot0:getMaxDay() < slot1 and slot0:getMaxDay() or slot1
end

function slot0.getFinalGiftGetDay(slot0)
	slot3 = {}

	for slot7, slot8 in pairs(ActivityConfig.instance:getNorSignActivityCos(ActivityEnum.Activity.DragonBoatFestival)) do
		if slot0:isGiftUnlock(slot8.id) and slot0:isGiftGet(slot8.id) then
			table.insert(slot3, slot8.id)
		end
	end

	if GameUtil.getTabLen(slot3) > 0 then
		return slot3[#slot3]
	else
		return slot0:getLoginCount()
	end
end

function slot0.isGiftGet(slot0, slot1)
	slot2 = ActivityEnum.Activity.DragonBoatFestival

	if slot0:getMaxDay() < slot1 then
		return false
	end

	return ActivityType101Model.instance:isType101RewardGet(slot2, slot1)
end

function slot0.isGiftUnlock(slot0, slot1)
	return slot1 <= slot0:getLoginCount()
end

function slot0.getMaxDay(slot0)
	slot2 = 0

	for slot6, slot7 in pairs(DragonBoatFestivalConfig.instance:getDragonBoatCos()) do
		slot2 = slot7.day < slot2 and slot2 or slot7.day
	end

	return slot2
end

function slot0.getLoginCount(slot0)
	return ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.DragonBoatFestival)
end

function slot0.getMaxUnlockDay(slot0)
	return slot0:getLoginCount() <= slot0:getMaxDay() and slot0:getLoginCount() or slot0:getMaxDay()
end

slot0.instance = slot0.New()

return slot0
