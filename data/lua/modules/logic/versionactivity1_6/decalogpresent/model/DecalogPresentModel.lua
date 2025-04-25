module("modules.logic.versionactivity1_6.decalogpresent.model.DecalogPresentModel", package.seeall)

slot0 = class("DecalogPresentModel", BaseModel)
slot0.REWARD_INDEX = 1

function slot0.getDecalogPresentActId(slot0)
	return ActivityEnum.Activity.V2a5_DecaLogPresent
end

function slot0.isDecalogPresentOpen(slot0)
	slot1 = false

	if ActivityType101Model.instance:isOpen(slot0:getDecalogPresentActId()) then
		slot1 = true
	end

	return slot1
end

function slot0.isShowRedDot(slot0)
	slot1 = false

	if ActivityType101Model.instance:isOpen(slot0:getDecalogPresentActId()) then
		slot1 = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot2)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
