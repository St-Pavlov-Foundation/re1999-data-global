module("modules.logic.pcInput.activityAdapter.MainActivityAdapter", package.seeall)

local var_0_0 = class("MainActivityAdapter", BaseActivityAdapter)

var_0_0.keytoFunction = {
	function()
		BpController.instance:openBattlePassView()
	end,
	function()
		ActivityController.instance:openActivityBeginnerView()
	end,
	function()
		PlayerController.instance:openSelfPlayerView()
	end,
	function()
		MailController.instance:open()
	end,
	function()
		TaskController.instance:enterTaskViewCheckUnlock()
	end,
	function()
		BackpackController.instance:enterItemBackpack()
	end,
	function()
		StoreController.instance:openStoreView()
	end,
	function()
		ViewMgr.instance:openView(ViewName.MainThumbnailView)
		SettingsController.instance:openView()
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifySetMainViewVisible)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterCurActivity)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterActivityCenter)
	end,
	function()
		DungeonController.instance:enterDungeonView(true, true)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterRoom)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterRole)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterSummon)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterBook)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterAchievement)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterFriend)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterTravelCollection)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterNotice)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterSign)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterSetting)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterFeedback)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEnterStore)
	end
}

function var_0_0.ctor(arg_25_0)
	BaseActivityAdapter.ctor(arg_25_0)

	arg_25_0.keytoFunction = var_0_0.keytoFunction
	arg_25_0.activitid = PCInputModel.Activity.MainActivity

	arg_25_0:registerFunction()
end

function var_0_0.OnkeyUp(arg_26_0, arg_26_1)
	if ViewMgr.instance:IsPopUpViewOpen() and not ViewMgr.instance:isOpen(ViewName.MainThumbnailView) or ViewMgr.instance:isOpen(ViewName.SettingsView) then
		return
	end

	BaseActivityAdapter.OnkeyUp(arg_26_0, arg_26_1)
end

function var_0_0.OnkeyDown(arg_27_0, arg_27_1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	BaseActivityAdapter.OnkeyDown(arg_27_0, arg_27_1)
end

return var_0_0
