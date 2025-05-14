module("modules.logic.battlepass.view.BpBuyBonusItem", package.seeall)

local var_0_0 = class("BpBuyBonusItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_1_0.go)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0.mo = arg_2_1

	arg_2_0._itemIcon:setMOValue(arg_2_0.mo[1], arg_2_0.mo[2], arg_2_0.mo[3], nil, true)
	arg_2_0._itemIcon:isShowCount(arg_2_0.mo[1] ~= MaterialEnum.MaterialType.Hero)
	arg_2_0._itemIcon:setCountFontSize(40)
	arg_2_0._itemIcon:setScale(0.8)
	arg_2_0._itemIcon:showStackableNum2()
	arg_2_0._itemIcon:setHideLvAndBreakFlag(true)
	arg_2_0._itemIcon:hideEquipLvAndBreak(true)
end

function var_0_0.onDestroyView(arg_3_0)
	if arg_3_0._itemIcon then
		arg_3_0._itemIcon:onDestroy()
	end

	arg_3_0._itemIcon = nil
end

return var_0_0
