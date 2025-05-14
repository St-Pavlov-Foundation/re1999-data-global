module("modules.logic.room.view.transport.RoomTransportBuildingSkinItem", package.seeall)

local var_0_0 = class("RoomTransportBuildingSkinItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#simage_icon")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_click")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_reddot")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_selected")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_lock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._mo and arg_4_0._view and arg_4_0._view.viewContainer then
		arg_4_0._view.viewContainer:dispatchEvent(RoomEvent.TransportBuildingSkinSelect, arg_4_0._mo)
	end
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:_refreshUI()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselected, arg_9_1)
end

function var_0_0._refreshUI(arg_10_0)
	local var_10_0 = arg_10_0._mo
	local var_10_1 = var_10_0 and var_10_0.config or var_10_0.buildingCfg

	if var_10_0 then
		arg_10_0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. var_10_1.icon))

		local var_10_2 = RoomBuildingEnum.RareFrame[var_10_1.rare] or RoomBuildingEnum.RareFrame[1]

		UISpriteSetMgr.instance:setRoomSprite(arg_10_0._imagerare, var_10_2)
		gohelper.setActive(arg_10_0._golock, var_10_0.isLock)
	end
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

var_0_0.prefabPath = "ui/viewres/room/transport/roomtransportbuildingskinitem.prefab"

return var_0_0
