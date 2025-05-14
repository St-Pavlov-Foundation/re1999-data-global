module("modules.logic.room.view.topright.RoomViewTopRightStrengthItem", package.seeall)

local var_0_0 = class("RoomViewTopRightStrengthItem", RoomViewTopRightBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._strengthId = arg_2_0._param.strengthId
	arg_2_0._strengthShowType = arg_2_0._param.strengthShowType or 0
	arg_2_0._resourceItem.simageicon = gohelper.findChildSingleImage(arg_2_0._resourceItem.go, "icon")

	local var_2_0 = ItemModel.instance:getItemSmallIcon(arg_2_0._strengthId)

	arg_2_0._resourceItem.simageicon:LoadImage(var_2_0)
	arg_2_0:_setShow(true)
end

function var_0_0._onClick(arg_3_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, arg_3_0._strengthId, nil, nil, nil, nil, true)
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(RoomBuildingController.instance, RoomEvent.ConfirmBuilding, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomBuildingController.instance, RoomEvent.UnUseBuilding, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomBuildingController.instance, RoomEvent.UpdateBuildingLocalLevels, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomBuildingController.instance, RoomEvent.UpdateBuildingLevels, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_4_0._refreshUI, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0._refreshUI(arg_6_0)
	local var_6_0 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, arg_6_0._strengthId)

	arg_6_0._resourceItem.txtquantity.text = string.format("%s/%s", GameUtil.numberDisplay(var_6_0), GameUtil.numberDisplay(var_6_0))

	gohelper.setActive(arg_6_0._resourceItem.go, arg_6_0._strengthShowType ~= 1 or var_6_0 > 0)
end

function var_0_0._customOnDestory(arg_7_0)
	arg_7_0._resourceItem.simageicon:UnLoadImage()
end

return var_0_0
