module("modules.logic.room.view.RoomBlockPackageItem", package.seeall)

local var_0_0 = class("RoomBlockPackageItem", ListScrollCellExtend)

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

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnItem:RemoveClickListener()
end

function var_0_0._btnitemOnClick(arg_5_0)
	RoomHelper.hideBlockPackageReddot(arg_5_0._packageId)
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlockPackage, arg_5_0._packageId)
end

function var_0_0.getGO(arg_6_0)
	return arg_6_0._go
end

function var_0_0.setShowIcon(arg_7_0, arg_7_1)
	arg_7_0._isShowIcon = arg_7_1
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	arg_8_0._isSelect = arg_8_1

	gohelper.setActive(arg_8_0._goselect, arg_8_1)
	arg_8_0:_onSelectUI()
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._showPackageMO = arg_9_1

	arg_9_0:setPackageId(arg_9_1.id)
end

function var_0_0.getPackageId(arg_10_0)
	return arg_10_0._packageId
end

function var_0_0.setPackageId(arg_11_0, arg_11_1)
	arg_11_0._packageId = arg_11_1
	arg_11_0._packageCfg = RoomConfig.instance:getBlockPackageConfig(arg_11_1) or nil
	arg_11_0._packageMO = RoomInventoryBlockModel.instance:getPackageMOById(arg_11_1)
	arg_11_0._blockNum = arg_11_0._packageMO and arg_11_0._packageMO:getUnUseCount() or 0

	RedDotController.instance:addRedDot(arg_11_0._goreddot, RedDotEnum.DotNode.RoomBlockPackage, arg_11_0._packageId)
	arg_11_0:_refreshUI()
end

function var_0_0._refreshUI(arg_12_0)
	if not arg_12_0._packageCfg then
		return
	end

	arg_12_0._txtname.text = arg_12_0._packageCfg.name
	arg_12_0._txtnum.text = arg_12_0._blockNum
	arg_12_0._txtdegree.text = arg_12_0._packageCfg.blockBuildDegree * arg_12_0._blockNum

	gohelper.setActive(arg_12_0._goempty, arg_12_0._blockNum == 0)
	gohelper.setActive(arg_12_0._txtnum.gameObject, arg_12_0._blockNum > 0)
	gohelper.setActive(arg_12_0._txtdegree.gameObject, arg_12_0._blockNum > 0)
	arg_12_0:_onRefreshUI()
end

function var_0_0.onDestroy(arg_13_0)
	return
end

function var_0_0._onInit(arg_14_0, arg_14_1)
	return
end

function var_0_0._onRefreshUI(arg_15_0)
	return
end

function var_0_0._onSelectUI(arg_16_0)
	return
end

return var_0_0
