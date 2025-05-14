module("modules.logic.room.view.RoomViewDebugBuilding", package.seeall)

local var_0_0 = class("RoomViewDebugBuilding", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._godebugbuilding = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/go_debugbuilding")
	arg_4_0._btnclose = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/go_debugbuilding/btn_close")
	arg_4_0._scrolldebugbuilding = gohelper.findChildScrollRect(arg_4_0.viewGO, "go_normalroot/go_debugbuilding/scroll_debugbuilding")

	arg_4_0._btnclose:AddClickListener(arg_4_0._btncloseOnClick, arg_4_0)

	arg_4_0._isShowDebugBuilding = false

	gohelper.setActive(arg_4_0._godebugbuilding, false)

	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0._btncloseOnClick(arg_5_0)
	RoomDebugController.instance:setDebugBuildingListShow(false)
end

function var_0_0._refreshUI(arg_6_0)
	return
end

function var_0_0._debugBuildingListViewShowChanged(arg_7_0, arg_7_1)
	local var_7_0

	var_7_0 = arg_7_0._isShowDebugBuilding ~= arg_7_1
	arg_7_0._isShowDebugBuilding = arg_7_1

	RoomDebugBuildingListModel.instance:clearSelect()
	gohelper.setActive(arg_7_0._godebugbuilding, arg_7_1)

	if arg_7_1 then
		RoomDebugBuildingListModel.instance:setDebugBuildingList()

		arg_7_0._scrolldebugbuilding.horizontalNormalizedPosition = 0
	end
end

function var_0_0._addBtnAudio(arg_8_0)
	gohelper.addUIClickAudio(arg_8_0._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_refreshUI()
	arg_9_0:_addBtnAudio()
	arg_9_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, arg_9_0._debugBuildingListViewShowChanged, arg_9_0)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._btnclose:RemoveClickListener()
	arg_11_0._scrolldebugbuilding:RemoveOnValueChanged()
end

return var_0_0
