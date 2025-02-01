module("modules.logic.versionactivity1_9.semmelweisgift.model.SemmelWeisGiftModel", package.seeall)

slot0 = class("SemmelWeisGiftModel", BaseModel)
slot0.REWARD_INDEX = 1

function slot0.getSemmelWeisGiftActId(slot0)
	return ActivityEnum.Activity.V1a9_SemmelWeisGift
end

function slot0.isSemmelWeisGiftOpen(slot0)
	slot1 = false

	if ActivityType101Model.instance:isOpen(slot0:getSemmelWeisGiftActId()) then
		slot1 = true
	end

	return slot1
end

function slot0.isShowRedDot(slot0)
	slot1 = false

	if ActivityType101Model.instance:isOpen(slot0:getSemmelWeisGiftActId()) then
		slot1 = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot2)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
