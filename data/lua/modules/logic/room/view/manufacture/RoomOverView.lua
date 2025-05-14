module("modules.logic.room.view.manufacture.RoomOverView", package.seeall)

local var_0_0 = class("RoomOverView", BaseView)
local var_0_1 = 0.05

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnmanufacture = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "topTab/#btn_manufacture")
	arg_1_0._gomannuselect = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_manufacture/select")
	arg_1_0._gomannuunselect = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_manufacture/unselect")
	arg_1_0._gomannuReddot = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_manufacture/#go_reddot")
	arg_1_0._btntransport = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "topTab/#btn_transport")
	arg_1_0._gotransportselect = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_transport/select")
	arg_1_0._gotransportunselect = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_transport/unselect")
	arg_1_0._gotransportReddot = gohelper.findChild(arg_1_0.viewGO, "topTab/#btn_transport/#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmanufacture:AddClickListener(arg_2_0._btnmanufactureOnClick, arg_2_0)
	arg_2_0._btntransport:AddClickListener(arg_2_0._btntransportOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onViewChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onViewChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmanufacture:RemoveClickListener()
	arg_3_0._btntransport:RemoveClickListener()
end

function var_0_0._btnmanufactureOnClick(arg_4_0)
	arg_4_0:_btnTabClick(RoomOverViewContainer.SubViewTabId.Manufacture)
end

function var_0_0._btntransportOnClick(arg_5_0)
	arg_5_0:_btnTabClick(RoomOverViewContainer.SubViewTabId.Transport)
end

function var_0_0._btnTabClick(arg_6_0, arg_6_1)
	if not arg_6_0.viewContainer:checkTabId(arg_6_1) then
		logError(string.format("RoomOverView._btnTabOnClick error, no subview, tabId:%s", arg_6_1))

		return
	end

	if arg_6_0._curSelectTab == arg_6_1 then
		return
	end

	arg_6_0.viewContainer:switchTab(arg_6_1)

	arg_6_0._curSelectTab = arg_6_1

	arg_6_0:refreshTab()
end

function var_0_0._onViewChange(arg_7_0, arg_7_1)
	if arg_7_1 ~= ViewName.RoomManufactureAddPopView and arg_7_1 ~= ViewName.RoomCritterListView and arg_7_1 ~= ViewName.RoomManufactureBuildingDetailView then
		return
	end

	if arg_7_0._willClose then
		return
	end

	TaskDispatcher.cancelTask(arg_7_0._delayCheckLeft, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._delayCheckLeft, arg_7_0, var_0_1)
end

function var_0_0._delayCheckLeft(arg_8_0)
	local var_8_0 = false
	local var_8_1 = ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView)
	local var_8_2 = ViewMgr.instance:isOpen(ViewName.RoomCritterListView) or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingDetailView)

	if var_8_1 or var_8_2 then
		var_8_0 = true
	end

	if var_8_0 ~= arg_8_0._isLeft then
		arg_8_0:playAnim(var_8_0 and "left" or "right")

		arg_8_0._isLeft = var_8_0
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._tabSelectedGoDict = {}

	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.goSelected = arg_9_0._gomannuselect
	var_9_0.goUnSelected = arg_9_0._gomannuunselect
	arg_9_0._tabSelectedGoDict[RoomOverViewContainer.SubViewTabId.Manufacture] = var_9_0

	local var_9_1 = arg_9_0:getUserDataTb_()

	var_9_1.goSelected = arg_9_0._gotransportselect
	var_9_1.goUnSelected = arg_9_0._gotransportunselect
	arg_9_0._tabSelectedGoDict[RoomOverViewContainer.SubViewTabId.Transport] = var_9_1
	arg_9_0._animator = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._isLeft = false
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._willClose = false
	arg_11_0._curSelectTab = arg_11_0.viewContainer:getDefaultSelectedTab()

	arg_11_0:refreshTab()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_lower)
	RedDotController.instance:addRedDot(arg_11_0._gomannuReddot, RedDotEnum.DotNode.ManufactureOverview)
end

function var_0_0.refreshTab(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._tabSelectedGoDict) do
		local var_12_0 = iter_12_0 == arg_12_0._curSelectTab

		gohelper.setActive(iter_12_1.goSelected, var_12_0)
		gohelper.setActive(iter_12_1.goUnSelected, not var_12_0)
	end
end

function var_0_0.playAnim(arg_13_0, arg_13_1)
	arg_13_0._animator.enabled = true

	arg_13_0._animator:Play(arg_13_1, 0, 0)
end

function var_0_0.onClose(arg_14_0)
	arg_14_0._willClose = true

	TaskDispatcher.cancelTask(arg_14_0._delayCheckLeft, arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._isLeft = false
end

return var_0_0
