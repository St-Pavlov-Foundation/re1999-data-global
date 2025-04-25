module("modules.logic.versionactivity2_5.act182.model.Activity182Model", package.seeall)

slot0 = class("Activity182Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.actMoDic = {}
end

function slot0.setActInfo(slot0, slot1)
	slot0.curActId = slot1.activityId

	if slot0.actMoDic[slot0.curActId] then
		slot2:update(slot1)
	else
		slot2 = Act182MO.New()

		slot2:init(slot1)

		slot0.actMoDic[slot0.curActId] = slot2
	end

	Activity182Controller.instance:dispatchEvent(Activity182Event.UpdateInfo)
end

function slot0.getCurActId(slot0)
	return slot0.curActId
end

function slot0.getActMo(slot0, slot1)
	if not slot0.actMoDic[slot1 or slot0.curActId] then
		logError("dont exist actMo" .. tostring(slot1))
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
