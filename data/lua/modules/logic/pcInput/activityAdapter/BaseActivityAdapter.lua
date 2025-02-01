module("modules.logic.pcInput.activityAdapter.BaseActivityAdapter", package.seeall)

slot0 = class("BaseActivityAdapter")

function slot0.ctor(slot0)
	slot0.keytoFunction = {}
	slot0.activitid = nil
	slot0._registeredKey = {}
end

function slot0.registerFunction(slot0)
	if not PCInputModel.instance:getActivityKeys(slot0.activitid) then
		return
	end

	slot0._registeredKey = slot1

	for slot5, slot6 in pairs(slot1) do
		PCInputController.instance:registerKey(slot6[4], ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function slot0.unRegisterFunction(slot0)
	for slot4, slot5 in pairs(slot0._registeredKey) do
		PCInputController.instance:unregisterKey(slot5[4], ZProj.PCInputManager.PCInputEvent.KeyUp)
	end

	slot0._registeredKey = {}
end

function slot0.OnkeyUp(slot0, slot1)
	if not PCInputModel.instance:getkeyidBykeyName(slot0.activitid, slot1) then
		return
	end

	if slot0.keytoFunction[slot2] then
		slot3()
	end
end

function slot0.OnkeyDown(slot0, slot1)
	if not PCInputModel.instance:getkeyidBykeyName(slot0.activitid, slot1) then
		logError("keyName not exist in keyBinding")

		return
	end

	if slot0.keytoFunction[slot2] then
		slot3()
	end
end

function slot0.destroy(slot0)
	slot0:unRegisterFunction()
end

return slot0
