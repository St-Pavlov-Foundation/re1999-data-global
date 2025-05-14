module("modules.logic.room.view.transport.RoomTransportSiteItem", package.seeall)

local var_0_0 = class("RoomTransportSiteItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnswithItem:AddClickListener(arg_2_0._btnswithItemOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswithItem:RemoveClickListener()
end

function var_0_0._btnswithItemOnClick(arg_4_0)
	if arg_4_0._view and arg_4_0._view.viewContainer then
		arg_4_0._view.viewContainer:dispatchEvent(RoomEvent.TransportSiteSelect, arg_4_0:getDataMO())
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._btnswithItem = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "btn_swithItem")
	arg_5_0._goselect = gohelper.findChild(arg_5_0.viewGO, "btn_swithItem/go_select")
	arg_5_0._imageselecticon = gohelper.findChildImage(arg_5_0.viewGO, "btn_swithItem/go_select/image_selecticon")
	arg_5_0._gounselect = gohelper.findChild(arg_5_0.viewGO, "btn_swithItem/go_unselect")
	arg_5_0._imageunselecticon = gohelper.findChildImage(arg_5_0.viewGO, "btn_swithItem/go_unselect/image_unselecticon")
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.getDataMO(arg_8_0)
	return arg_8_0._dataMO
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._dataMO = arg_9_1

	arg_9_0:refreshUI()
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselect, arg_10_1)
	gohelper.setActive(arg_10_0._gounselect, not arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = arg_12_0._dataMO and RoomMapTransportPathModel.instance:getTransportPathMO(arg_12_0._dataMO.pathId)
	local var_12_1 = false
	local var_12_2 = var_12_0 and RoomTransportHelper.getVehicleCfgByBuildingId(var_12_0.buildingId, var_12_0.buildingSkinId)

	if var_12_2 then
		if var_12_2.id ~= arg_12_0._lastVehicleId then
			UISpriteSetMgr.instance:setRoomSprite(arg_12_0._imageselecticon, var_12_2.buildIcon)
			UISpriteSetMgr.instance:setRoomSprite(arg_12_0._imageunselecticon, var_12_2.buildIcon)
		end

		var_12_1 = true
	end

	if arg_12_0._lastIsActive ~= var_12_1 then
		gohelper.setActive(arg_12_0._imageselecticon, var_12_1)
		gohelper.setActive(arg_12_0._imageunselecticon, var_12_1)
	end
end

return var_0_0
