module("modules.logic.room.view.transport.RoomTransportCritterItem", package.seeall)

local var_0_0 = class("RoomTransportCritterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_icon")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_info")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_info/#txt_name")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_info/#go_skill")
	arg_1_0._simageskill = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#go_info/#go_skill/#simage_skill")
	arg_1_0._golayoutAttr = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_info/#go_layoutAttr")
	arg_1_0._goattrItem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem")
	arg_1_0._txtattrValue = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem/#txt_attrValue")
	arg_1_0._simageattrIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#go_info/#go_layoutAttr/#go_attrItem/#simage_attrIcon")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_selected")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_click")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_detail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._mo and arg_4_0._view and arg_4_0._view.viewContainer then
		arg_4_0._view.viewContainer:dispatchEvent(RoomEvent.TransportCritterSelect, arg_4_0._mo)
	end
end

function var_0_0._btndetailOnClick(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	arg_9_0:_refreshUI()
end

function var_0_0._refreshUI(arg_10_0)
	local var_10_0 = arg_10_0._mo:getId()
	local var_10_1 = arg_10_0._mo:getDefineId()
	local var_10_2 = arg_10_0._mo:getDefineCfg()

	if not arg_10_0.critterIcon then
		arg_10_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_10_0._goicon)
	end

	arg_10_0.critterIcon:setMOValue(var_10_0, var_10_1)

	arg_10_0._txtname.text = var_10_2.name
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

var_0_0.prefabPath = "ui/viewres/room/transport/roomtransportcritteritem.prefab"

return var_0_0
