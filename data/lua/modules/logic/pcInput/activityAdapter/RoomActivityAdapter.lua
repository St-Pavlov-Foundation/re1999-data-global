module("modules.logic.pcInput.activityAdapter.RoomActivityAdapter", package.seeall)

local var_0_0 = class("RoomActivityAdapter", BaseActivityAdapter)

var_0_0.keytoFunction = {
	function()
		local var_1_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() and not ViewMgr.instance:isOpen(ViewName.RoomCharacterPlaceView) or not var_1_0 then
			return
		end

		HelpController.instance:showHelp(HelpEnum.HelpId.RoomOb, true)
	end,
	function()
		local var_2_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not var_2_0 then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomMarket)
	end,
	function()
		local var_3_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not var_3_0 then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomBellTower)
	end,
	function()
		local var_4_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not var_4_0 then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyRoomCharactorFaith)
	end,
	function()
		local var_5_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not var_5_0 then
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
		local var_8_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not var_8_0 then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBuy)
	end,
	[10] = function()
		local var_9_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not var_9_0 then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyLayout)
	end,
	[11] = function()
		local var_10_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not var_10_0 then
			return
		end

		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyPlace)
	end,
	[12] = function()
		local var_11_0 = RoomController.instance:isObMode()

		if ViewMgr.instance:IsPopUpViewOpen() or not var_11_0 then
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
