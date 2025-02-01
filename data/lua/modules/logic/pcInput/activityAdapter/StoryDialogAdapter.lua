module("modules.logic.pcInput.activityAdapter.StoryDialogAdapter", package.seeall)

slot0 = class("StoryDialogAdapter", BaseActivityAdapter)
slot0.keytoFunction = {
	Space = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogNext)
	end,
	F1 = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogAuto)
	end,
	F2 = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSkip)
	end,
	F3 = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogExit)
	end,
	Alpha1 = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 1)
	end,
	Alpha2 = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 2)
	end,
	Alpha3 = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 3)
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
	for slot4, slot5 in pairs(slot0.keytoFunction) do
		PCInputController.instance:unregisterKey(slot4, ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
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
