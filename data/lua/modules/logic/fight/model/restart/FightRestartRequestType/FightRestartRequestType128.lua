module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType128", package.seeall)

local var_0_0 = class("FightRestartRequestType128", FightRestartRequestType1)

function var_0_0.requestFight(arg_1_0)
	arg_1_0._fight_work:onDone(true)
	DungeonFightController.instance:restartStage()
end

return var_0_0
