module("modules.logic.versionactivity1_4.act132.model.Activity132Model", package.seeall)

slot0 = class("Activity132Model", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setActivityInfo(slot0, slot1)
	if slot0:getActMoById(slot1.activityId) then
		slot2:init(slot1)
	end
end

function slot0.getActMoById(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0:getById(slot1) then
		slot0:addAtLast(Activity132Mo.New(slot1))
	end

	return slot2
end

function slot0.getContentState(slot0, slot1, slot2)
	if not slot0:getActMoById(slot1) then
		return
	end

	return slot3:getContentState(slot2)
end

function slot0.setSelectCollectId(slot0, slot1, slot2)
	if not slot0:getActMoById(slot1) then
		return
	end

	slot3:setSelectCollectId(slot2)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnChangeCollect)
end

function slot0.getSelectCollectId(slot0, slot1)
	if not slot0:getActMoById(slot1) then
		return
	end

	return slot2:getSelectCollectId()
end

function slot0.setContentUnlock(slot0, slot1)
	if not slot0:getActMoById(slot1.activityId) then
		return
	end

	return slot2:setContentUnlock(slot1.contentId)
end

function slot0.checkClueRed(slot0, slot1, slot2)
	if not slot0:getActMoById(slot1) then
		return
	end

	return slot3:checkClueRed(slot2)
end

slot0.instance = slot0.New()

return slot0
