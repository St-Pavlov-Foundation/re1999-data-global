module("modules.logic.pcInput.activityAdapter.CommonActivityAdapter", package.seeall)

slot0 = class("CommonActivityAdapter", BaseActivityAdapter)
slot0.keytoFunction = {
	Esc = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyCommonCancel)
	end,
	Return = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyCommonConfirm)
	end
}

function slot0.ctor(slot0)
	slot0.keytoFunction = uv0.keytoFunction

	slot0:registerFunction()
end

function slot0.registerFunction(slot0)
	for slot4, slot5 in pairs(slot0.keytoFunction) do
		PCInputController.instance:registerKey(slot4, ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function slot0.unRegisterFunction(slot0)
end

function slot0.OnkeyUp(slot0, slot1)
	if slot0.keytoFunction[slot1] then
		slot2()
	end
end

function slot0.OnkeyDown(slot0, slot1)
	if slot0.keytoFunction[slot1] then
		slot2()
	end
end

function slot0.destroy(slot0)
	slot0:unRegisterFunction()
end

return slot0
