module("modules.logic.pcInput.activityAdapter.RoomActivityAdapter", package.seeall)

slot0 = class("RoomActivityAdapter", BaseActivityAdapter)
slot0.keytoFunction = {
	function ()
		HelpController.instance:showHelp(HelpEnum.HelpId.RoomOb, true)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomMarket)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomBellTower)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomCharactorFaith)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomCharactorFaithFull)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyHide)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.Notifylocate)
	end,
	[9] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBuy)
	end,
	[10] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyLayout)
	end,
	[11] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyPlace)
	end,
	[12] = function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEdit)
	end
}

function slot0.ctor(slot0)
	BaseActivityAdapter.ctor(slot0)

	slot0.keytoFunction = uv0.keytoFunction
	slot0.activitid = PCInputModel.Activity.room

	slot0:registerFunction()
end

function slot0.OnkeyUp(slot0, slot1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	BaseActivityAdapter.OnkeyUp(slot0, slot1)
end

return slot0
