module("modules.logic.room.view.transport.RoomTransportLineItem", package.seeall)

local var_0_0 = class("RoomTransportLineItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btnitemclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_itemclick")
	arg_1_0._imagetype1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_type1")
	arg_1_0._imagetype2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_type2")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_select")
	arg_1_0._btndelectPath = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_delectPath")
	arg_1_0._golinkfail = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_linkfail")
	arg_1_0._golinksuccess = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_linksuccess")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnitemclick:AddClickListener(arg_2_0._btnitemclickOnClick, arg_2_0)
	arg_2_0._btndelectPath:AddClickListener(arg_2_0._btndelectPathOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnitemclick:RemoveClickListener()
	arg_3_0._btndelectPath:RemoveClickListener()
end

function var_0_0._btnitemclickOnClick(arg_4_0)
	if arg_4_0._view and arg_4_0._view.viewContainer then
		arg_4_0._view.viewContainer:dispatchEvent(RoomEvent.TransportPathSelectLineItem, arg_4_0:getDataMO())
	end
end

function var_0_0._btndelectPathOnClick(arg_5_0)
	local var_5_0 = arg_5_0:getTransportPathMO()

	if var_5_0 and var_5_0:isLinkFinish() or var_5_0:getHexPointCount() > 0 then
		var_5_0:clear()
		var_5_0:setIsEdit(true)
		arg_5_0:refreshLinkUI()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._gofinishAnim = gohelper.findChild(arg_6_0._golinksuccess, "finish")

	gohelper.setActive(arg_6_0._goselect, false)
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._dataMO = arg_9_1

	arg_9_0:refreshUI()
end

function var_0_0.getDataMO(arg_10_0)
	return arg_10_0._dataMO
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goselect, arg_11_1)
end

function var_0_0.refreshUI(arg_12_0)
	gohelper.setActive(arg_12_0._gocontent, arg_12_0._dataMO ~= nil)

	if arg_12_0._dataMO then
		UISpriteSetMgr.instance:setRoomSprite(arg_12_0._imagetype1, RoomBuildingEnum.BuildingTypeLineIcon[arg_12_0._dataMO.fromType])
		UISpriteSetMgr.instance:setRoomSprite(arg_12_0._imagetype2, RoomBuildingEnum.BuildingTypeLineIcon[arg_12_0._dataMO.toType])
	end

	arg_12_0:refreshLinkUI()
end

function var_0_0.refreshLinkUI(arg_13_0)
	local var_13_0 = arg_13_0:_isCheckLinkFinish()

	gohelper.setActive(arg_13_0._btndelectPath, var_13_0)
	gohelper.setActive(arg_13_0._golinksuccess, var_13_0)
	gohelper.setActive(arg_13_0._golinkfail, var_13_0 == false)

	if arg_13_0._isLinkFinishAnim ~= var_13_0 then
		if arg_13_0._isLinkFinishAnim ~= nil then
			gohelper.setActive(arg_13_0._gofinishAnim, var_13_0)
		end

		arg_13_0._isLinkFinishAnim = var_13_0
	end
end

function var_0_0._isCheckLinkFinish(arg_14_0)
	local var_14_0 = arg_14_0:getTransportPathMO()

	if var_14_0 and var_14_0:isLinkFinish() then
		return true
	end

	return false
end

function var_0_0.getTransportPathMO(arg_15_0)
	if arg_15_0._dataMO then
		return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(arg_15_0._dataMO.fromType, arg_15_0._dataMO.toType)
	end
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
