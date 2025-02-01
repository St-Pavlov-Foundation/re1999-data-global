module("modules.logic.versionactivity1_4.act136.model.Activity136Model", package.seeall)

slot0 = class("Activity136Model", BaseModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.setActivityInfo(slot0, slot1)
	slot0.curActivity136Id = slot1.activityId
	slot0.alreadyReceivedCharacterId = slot1.selectHeroId

	Activity136Controller.instance:dispatchEvent(Activity136Event.ActivityDataUpdate)
end

function slot0.isActivity136InOpen(slot0, slot1)
	slot2 = false

	if slot0:getCurActivity136Id() then
		slot4, slot5, slot6 = ActivityHelper.getActivityStatusAndToast(slot3)

		if slot4 == ActivityEnum.ActivityStatus.Normal then
			slot2 = true
		elseif slot5 and slot1 then
			GameFacade.showToastWithTableParam(slot5, slot6)
		end
	end

	return slot2
end

function slot0.hasReceivedCharacter(slot0)
	return slot0:getAlreadyReceivedCharacterId() and slot1 ~= 0
end

function slot0.isShowRedDot(slot0)
	slot1 = false

	if slot0:isActivity136InOpen() then
		slot1 = not slot0:hasReceivedCharacter()
	end

	return slot1
end

function slot0.getAlreadyReceivedCharacterId(slot0)
	return slot0.alreadyReceivedCharacterId
end

function slot0.getCurActivity136Id(slot0)
	return slot0.curActivity136Id
end

function slot0.clear(slot0)
	slot0.curActivity136Id = nil
	slot0.alreadyReceivedCharacterId = 0

	uv0.super.clear(slot0)
end

slot0.instance = slot0.New()

return slot0
