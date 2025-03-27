module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyEvent", package.seeall)

slot0 = class("WaitGuideActionAnyEvent", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot4 = slot2[2]
	slot5 = slot2[3]
	slot0._param = slot2[4]
	slot0._controller = _G[slot2[1]]

	if not slot0._controller then
		logError("WaitGuideActionAnyEvent controllerName error:" .. tostring(slot3))

		return
	end

	slot0._eventModule = _G[slot4]

	if not slot0._eventModule then
		logError("WaitGuideActionAnyEvent eventModuleName error:" .. tostring(slot4))

		return
	end

	slot0._eventName = slot0._eventModule[slot5]

	if not slot0._eventName then
		logError("WaitGuideActionAnyEvent eventName error:" .. tostring(slot5))

		return
	end

	slot0._controller.instance:registerCallback(slot0._eventName, slot0._onReceiveEvent, slot0)
end

function slot0._onReceiveEvent(slot0, slot1)
	if slot0:checkGuideLock() then
		return
	end

	slot3 = false

	if type(slot1) == "number" then
		slot1 = tostring(slot1)
	elseif slot2 == "boolean" then
		slot1 = tostring(slot1)
	elseif slot2 == "function" then
		slot3 = slot1(slot0._param)
	end

	if not slot3 and slot0._param and slot0._param ~= slot1 then
		return
	end

	slot0._controller.instance:unregisterCallback(slot0._eventName, slot0._onReceiveEvent, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._controller then
		slot0._controller.instance:unregisterCallback(slot0._eventName, slot0._onReceiveEvent, slot0)
	end
end

return slot0
