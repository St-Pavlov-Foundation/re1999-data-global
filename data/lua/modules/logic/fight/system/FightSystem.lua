module("modules.logic.fight.system.FightSystem", package.seeall)

local var_0_0 = class("FightSystem")

function var_0_0.dispose(arg_1_0)
	FightPlayCardModel.instance:onEndRound()
	FightModel.instance:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
