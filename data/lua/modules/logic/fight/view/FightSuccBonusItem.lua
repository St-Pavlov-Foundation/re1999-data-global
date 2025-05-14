module("modules.logic.fight.view.FightSuccBonusItem", package.seeall)

local var_0_0 = class("FightSuccBonusItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = gohelper.findChild(arg_1_1, "itemIcon")

	arg_1_0._itemIcon = IconMgr.instance:getCommonItemIcon(var_1_0)
	arg_1_0._tagGO = gohelper.findChild(arg_1_1, "tag")
	arg_1_0._imgFirstGO = gohelper.findChild(arg_1_1, "tag/imgFirst")
	arg_1_0._imgNormalGO = gohelper.findChild(arg_1_1, "tag/imgNormal")
	arg_1_0._imgHardGO = gohelper.findChild(arg_1_1, "tag/imgHard")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._itemIcon:onUpdateMO(arg_2_1)
	arg_2_0._itemIcon:setCantJump(true)
end

return var_0_0
