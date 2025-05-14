module("modules.logic.room.view.topright.RoomViewTopRightBlockItem", package.seeall)

local var_0_0 = class("RoomViewTopRightBlockItem", RoomViewTopRightBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._resourceItem.imageicon = gohelper.findChildImage(arg_2_0._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(arg_2_0._resourceItem.imageicon, "icon_zongkuai_light")
	recthelper.setSize(arg_2_0._resourceItem.imageicon.transform, 68, 52)
	arg_2_0:_setShow(true)
end

function var_0_0._imageLoaded(arg_3_0)
	arg_3_0._resourceItem.imageicon:SetNativeSize()
end

function var_0_0._onClick(arg_4_0)
	if RoomController.instance:isVisitMode() then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.Block
	})
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.ClientTryBackBlock, arg_5_0._refreshUI, arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBackBlock, arg_5_0._refreshUI, arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBackBlock, arg_5_0._refreshUI, arg_5_0)
	arg_5_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, arg_5_0._refreshUI, arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateInventoryCount, arg_5_0._refreshUI, arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmSelectBlockPackage, arg_5_0._refreshUI, arg_5_0)
	arg_5_0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_5_0._refreshUI, arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.ClientPlaceBlock, arg_5_0._refreshAddNumUI, arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBlock, arg_5_0._refreshAddNumUI, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0._getPlaceBlockNum(arg_7_0)
	if RoomController.instance:isEditMode() and RoomMapBlockModel.instance:getTempBlockMO() then
		return 1
	end

	return 0
end

function var_0_0._refreshAddNumUI(arg_8_0)
	local var_8_0 = arg_8_0:_getPlaceBlockNum()

	if var_8_0 > 0 then
		arg_8_0._resourceItem.txtaddNum.text = "+" .. var_8_0
	end

	gohelper.setActive(arg_8_0._resourceItem.txtaddNum, var_8_0 > 0)
end

function var_0_0._refreshUI(arg_9_0)
	local var_9_0 = RoomMapBlockModel.instance:getConfirmBlockCount()

	if RoomController.instance:isVisitMode() then
		arg_9_0._resourceItem.txtquantity.text = var_9_0
	else
		local var_9_1 = RoomMapBlockModel.instance:getMaxBlockCount()

		arg_9_0._resourceItem.txtquantity.text = string.format("%s/%s", var_9_0, var_9_1)
	end

	arg_9_0:_refreshAddNumUI()
end

function var_0_0._customOnDestory(arg_10_0)
	return
end

return var_0_0
