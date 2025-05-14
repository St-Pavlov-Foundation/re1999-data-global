module("modules.logic.antique.view.AntiqueBackpackItem", package.seeall)

local var_0_0 = class("AntiqueBackpackItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_1_1)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	arg_4_0._itemIcon:setMOValue(MaterialEnum.MaterialType.Antique, arg_4_1.id, 1)
	arg_4_0._itemIcon:isShowCount(false)
	arg_4_0._itemIcon:isShowName(true)
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._showItem, arg_5_0)
end

return var_0_0
