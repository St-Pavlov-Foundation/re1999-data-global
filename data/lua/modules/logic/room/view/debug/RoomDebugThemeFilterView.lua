module("modules.logic.room.view.debug.RoomDebugThemeFilterView", package.seeall)

local var_0_0 = class("RoomDebugThemeFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._gobuildingArrow = gohelper.findChild(arg_1_0.viewGO, "#go_content/bg/#go_buildingArrow")
	arg_1_0._goblockpackageArrow = gohelper.findChild(arg_1_0.viewGO, "#go_content/bg/#go_blockpackageArrow")
	arg_1_0._goall = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_all")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_all/#go_selected")
	arg_1_0._gounselected = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_all/#go_unselected")
	arg_1_0._btnall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#go_all/#btn_all")
	arg_1_0._scrolltheme = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_content/#scroll_theme")
	arg_1_0._gothemeitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_themeitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnall:AddClickListener(arg_2_0._btnallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnall:RemoveClickListener()
end

function var_0_0._btnallOnClick(arg_4_0)
	if RoomDebugThemeFilterListModel.instance:getIsAll() then
		RoomDebugThemeFilterListModel.instance:clearFilterData()
	else
		RoomDebugThemeFilterListModel.instance:selectAll()
	end

	RoomDebugThemeFilterListModel.instance:onModelUpdate()
	RoomDebugController.instance:dispatchEvent(RoomEvent.UIRoomThemeFilterChanged)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._onThemeFilterChanged(arg_6_0)
	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = RoomDebugThemeFilterListModel.instance:getIsAll()

	if arg_7_0._lastSelect ~= var_7_0 then
		arg_7_0._lastSelect = var_7_0

		gohelper.setActive(arg_7_0._goselected, var_7_0)
		gohelper.setActive(arg_7_0._gounselected, not var_7_0)
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(RoomDebugController.instance, RoomEvent.UIRoomThemeFilterChanged, arg_9_0._onThemeFilterChanged, arg_9_0)
	arg_9_0:_refreshUI()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
