module("modules.logic.room.view.manufacture.RoomOneKeyAddPopItem", package.seeall)

local var_0_0 = class("RoomOneKeyAddPopItem", RoomManufactureFormulaItem)

function var_0_0.addEvents(arg_1_0)
	var_0_0.super.addEvents(arg_1_0)
	arg_1_0:addEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, arg_1_0.refreshSelected, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	var_0_0.super.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, arg_2_0.refreshSelected, arg_2_0)
end

function var_0_0.onClick(arg_3_0)
	local var_3_0 = OneKeyAddPopListModel.MINI_COUNT
	local var_3_1, var_3_2 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if var_3_1 == arg_3_0.id then
		var_3_0 = var_3_2
	end

	ManufactureController.instance:oneKeySelectCustomManufactureItem(arg_3_0.id, var_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)

	arg_4_0.goselected1 = gohelper.findChild(arg_4_0.viewGO, "#go_needMat/#go_selected")
	arg_4_0.goselected2 = gohelper.findChild(arg_4_0.viewGO, "#go_noMat/#go_selected")

	gohelper.setActive(arg_4_0._txtneedMattime, false)
	gohelper.setActive(arg_4_0._txtnoMattime, false)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	var_0_0.super.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0:refreshSelected()
end

function var_0_0.refreshItemName(arg_6_0)
	local var_6_0 = ManufactureConfig.instance:getManufactureItemName(arg_6_0.id)
	local var_6_1 = string.split(var_6_0, "*")

	arg_6_0._txtneedMatproductionName.text = var_6_1[1]
	arg_6_0._txtnoMatproductionName.text = var_6_1[1]
end

function var_0_0.refreshItemNum(arg_7_0)
	local var_7_0
	local var_7_1, var_7_2 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()
	local var_7_3 = ManufactureModel.instance:getManufactureItemCount(arg_7_0.id)

	if var_7_1 == arg_7_0.id then
		local var_7_4, var_7_5 = ManufactureConfig.instance:getManufactureItemUnitCountRange(arg_7_0.id)
		local var_7_6 = var_7_5 * var_7_2

		var_7_0 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_manufacture_one_key_add_count"), var_7_3, var_7_6)
	else
		var_7_0 = formatLuaLang("materialtipview_itemquantity", var_7_3)
	end

	arg_7_0._txtneedMatnum.text = var_7_0
	arg_7_0._txtnoMatnum.text = var_7_0
end

function var_0_0.refreshTime(arg_8_0)
	return
end

function var_0_0.refreshSelected(arg_9_0)
	local var_9_0 = OneKeyAddPopListModel.instance:getSelectedManufactureItem() == arg_9_0.id

	arg_9_0:refreshItemNum()
	gohelper.setActive(arg_9_0.goselected1, var_9_0)
	gohelper.setActive(arg_9_0.goselected2, var_9_0)
end

return var_0_0
