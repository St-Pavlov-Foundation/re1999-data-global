module("modules.logic.guide.controller.action.impl.GuideActionDispatchEvent", package.seeall)

slot0 = class("GuideActionDispatchEvent", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot4 = slot2[2]
	slot5 = slot2[3]
	slot6 = slot2[4]
	slot0._controller = getModuleDef(slot2[1])

	if not slot0._controller then
		logError("GuideActionDispatchEvent controllerName error:" .. tostring(slot3))
		slot0:onDone(true)

		return
	end

	slot0._eventModule = getModuleDef(slot4)

	if not slot0._eventModule then
		logError("GuideActionDispatchEvent eventModuleName error:" .. tostring(slot4))
		slot0:onDone(true)

		return
	end

	slot0._eventName = slot0._eventModule[slot5]

	if not slot0._eventName then
		logError("GuideActionDispatchEvent eventName error:" .. tostring(slot5))
		slot0:onDone(true)

		return
	end

	logNormal(string.format("%s dispatch %s %s param:%s", slot3, slot4, slot0._eventName or "nil", slot6 or "nil"))
	slot0._controller.instance:dispatchEvent(slot0._eventName, slot6)
	slot0:onDone(true)
end

return slot0
