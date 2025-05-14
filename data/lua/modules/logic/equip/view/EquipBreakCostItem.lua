module("modules.logic.equip.view.EquipBreakCostItem", package.seeall)

local var_0_0 = class("EquipBreakCostItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._icon = gohelper.findChild(arg_1_0.viewGO, "icon")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._item = IconMgr.instance:getCommonItemIcon(arg_4_0._icon)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0._item:setMOValue(arg_5_0._mo.type, arg_5_0._mo.id, arg_5_0._mo.quantity)

	local var_5_0 = arg_5_0._item:getCount()
	local var_5_1 = ItemModel.instance:getItemQuantity(arg_5_0._mo.type, arg_5_0._mo.id)

	if var_5_1 >= arg_5_0._mo.quantity then
		var_5_0.text = tostring(GameUtil.numberDisplay(var_5_1)) .. "/" .. tostring(GameUtil.numberDisplay(arg_5_0._mo.quantity))
	else
		var_5_0.text = "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(var_5_1)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(arg_5_0._mo.quantity))
	end
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	return
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
