module("modules.logic.room.view.transport.RoomTransportBuildingItem", package.seeall)

local var_0_0 = class("RoomTransportBuildingItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#simage_icon")
	arg_1_0._txtbuildingname = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_buildingname")
	arg_1_0._txtbuildingdec = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_buildingdec")
	arg_1_0._gobeplaced = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_beplaced")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_click")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_reddot")
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
	if arg_4_0._view and arg_4_0._view.viewContainer then
		arg_4_0._view.viewContainer:dispatchEvent(RoomEvent.TransportBuildingSelect, arg_4_0._mo)
	end

	if not arg_4_0._mo.isNeedToBuy then
		arg_4_0:_hideReddot()
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
	gohelper.setActive(arg_9_0._goselect, arg_9_1)
	gohelper.setActive(arg_9_0._gobeplaced, arg_9_0:_getIsUnse())
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0._refreshUI(arg_11_0)
	arg_11_0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. arg_11_0._mo:getIcon()))
	gohelper.setActive(arg_11_0._gobeplaced, arg_11_0:_getIsUnse())

	arg_11_0._txtbuildingname.text = arg_11_0._mo.config.name
	arg_11_0._txtbuildingdec.text = arg_11_0._mo.config.useDesc

	local var_11_0 = RoomBuildingEnum.RareFrame[arg_11_0._mo.config.rare] or RoomBuildingEnum.RareFrame[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_11_0._imagerare, var_11_0)
	gohelper.setActive(arg_11_0._goreddot, not arg_11_0._mo.use)
	gohelper.setActive(arg_11_0._golock, arg_11_0._mo.isNeedToBuy)

	if not arg_11_0._mo.use then
		RedDotController.instance:addRedDot(arg_11_0._goreddot, RedDotEnum.DotNode.RoomBuildingPlace, arg_11_0._mo.buildingId)
	end
end

function var_0_0._getIsUnse(arg_12_0)
	if arg_12_0._mo and arg_12_0._view and arg_12_0._view.viewContainer then
		return arg_12_0._mo.id == arg_12_0._view.viewContainer.useBuildingUid
	end

	return false
end

function var_0_0._hideReddot(arg_13_0)
	if arg_13_0._mo.use then
		return
	end

	local var_13_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBuildingPlace)

	if not var_13_0 or not var_13_0.infos then
		return
	end

	local var_13_1 = var_13_0.infos[arg_13_0._mo.buildingId]

	if not var_13_1 then
		return
	end

	if var_13_1.value > 0 then
		RoomRpc.instance:sendHideBuildingReddotRequset(arg_13_0._mo.buildingId)
	end
end

var_0_0.prefabPath = "ui/viewres/room/transport/roomtransportbuildingitem.prefab"

return var_0_0
