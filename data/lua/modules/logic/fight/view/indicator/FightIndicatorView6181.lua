module("modules.logic.fight.view.indicator.FightIndicatorView6181", package.seeall)

local var_0_0 = class("FightIndicatorView6181", FightIndicatorView)

function var_0_0.getCardConfig(arg_1_0)
	return Season123Config.instance:getSeasonEquipCo(arg_1_0:getCardId())
end

function var_0_0.getCardId(arg_2_0)
	return 180040
end

return var_0_0
