module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType34", package.seeall)

local var_0_0 = class("FightRestartRequestType34", FightRestartRequestType1)

function var_0_0.requestFight(arg_1_0)
	arg_1_0._fight_work:onDone(true)
	TowerController.instance:restartStage()
end

return var_0_0
