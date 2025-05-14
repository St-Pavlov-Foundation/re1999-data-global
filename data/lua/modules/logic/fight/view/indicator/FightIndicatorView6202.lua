module("modules.logic.fight.view.indicator.FightIndicatorView6202", package.seeall)

local var_0_0 = class("FightIndicatorView6202", FightIndicatorView)

function var_0_0.initView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.initView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.totalIndicatorNum = 4
end

function var_0_0.getCardConfig(arg_2_0)
	return Season123Config.instance:getSeasonEquipCo(arg_2_0:getCardId())
end

function var_0_0.getCardId(arg_3_0)
	return 200042
end

return var_0_0
