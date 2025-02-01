module("modules.logic.pcInput.activityAdapter.MainActivityAdapter", package.seeall)

slot0 = class("MainActivityAdapter", BaseActivityAdapter)
slot0.keytoFunction = {
	function ()
		BpController.instance:openBattlePassView()
	end,
	function ()
		ActivityController.instance:openActivityBeginnerView()
	end,
	function ()
		PlayerController.instance:openSelfPlayerView()
	end,
	function ()
		MailController.instance:open()
	end,
	function ()
		TaskController.instance:enterTaskViewCheckUnlock()
	end,
	function ()
		BackpackController.instance:enterItemBackpack()
	end,
	function ()
		StoreController.instance:openStoreView()
	end,
	function ()
		ViewMgr.instance:openView(ViewName.MainThumbnailView)
		SettingsController.instance:openView()
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifySetMainViewVisible)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterCurActivity)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterActivityCenter)
	end,
	function ()
		DungeonController.instance:enterDungeonView(true, true)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterRoom)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterRole)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterSummon)
	end
}

function slot0.ctor(slot0)
	BaseActivityAdapter.ctor(slot0)

	slot0.keytoFunction = uv0.keytoFunction
	slot0.activitid = PCInputModel.Activity.MainActivity

	slot0:registerFunction()
end

function slot0.OnkeyUp(slot0, slot1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	BaseActivityAdapter.OnkeyUp(slot0, slot1)
end

function slot0.OnkeyDown(slot0, slot1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	BaseActivityAdapter.OnkeyDown(slot0, slot1)
end

return slot0
