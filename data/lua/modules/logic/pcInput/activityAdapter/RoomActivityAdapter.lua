module("modules.logic.pcInput.activityAdapter.RoomActivityAdapter", package.seeall)

local var_0_0 = class("RoomActivityAdapter", BaseActivityAdapter)

var_0_0.keytoFunction = {
	function()
		HelpController.instance:showHelp(HelpEnum.HelpId.RoomOb, true)
	end,
	function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomMarket)
	end,
	function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomBellTower)
	end,
	function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomCharactorFaith)
	end,
	function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomCharactorFaithFull)
	end,
	function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyHide)
	end,
	function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.Notifylocate)
	end,
	[9] = function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBuy)
	end,
	[10] = function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyLayout)
	end,
	[11] = function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyPlace)
	end,
	[12] = function()
		if ViewMgr.instance:IsPopUpViewOpen() then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyEdit)
	end
}

function var_0_0.checkCanOpen(arg_12_0)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return false
	end

	return true
end

function var_0_0.ctor(arg_13_0)
	BaseActivityAdapter.ctor(arg_13_0)

	arg_13_0.keytoFunction = var_0_0.keytoFunction
	arg_13_0.activitid = PCInputModel.Activity.room

	arg_13_0:registerFunction()
end

function var_0_0.OnkeyUp(arg_14_0, arg_14_1)
	if GuideModel.instance:isDoingClickGuide() or not GuideModel.instance:isGuideFinish(406) then
		return
	end

	BaseActivityAdapter.OnkeyUp(arg_14_0, arg_14_1)
end

function var_0_0.OnkeyDown(arg_15_0, arg_15_1)
	if GuideModel.instance:isDoingClickGuide() or not GuideModel.instance:isGuideFinish(406) then
		return
	end

	BaseActivityAdapter.OnkeyUp(arg_15_0, arg_15_1)
end

return var_0_0
