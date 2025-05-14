module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType9", package.seeall)

local var_0_0 = class("FightRestartAbandonType9", FightRestartAbandonType1)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0._fight_work = arg_1_1
	arg_1_0._fightParam = arg_1_2
	arg_1_0._episode_config = arg_1_3
	arg_1_0._chapter_config = arg_1_4
end

function var_0_0.canRestart(arg_2_0)
	return (arg_2_0:episodeCostIsEnough())
end

return var_0_0
