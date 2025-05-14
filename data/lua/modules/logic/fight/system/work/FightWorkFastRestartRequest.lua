module("modules.logic.fight.system.work.FightWorkFastRestartRequest", package.seeall)

local var_0_0 = class("FightWorkFastRestartRequest", BaseWork)

function var_0_0.onStart(arg_1_0)
	DungeonFightController.instance:restartStage()
	arg_1_0:onDone(true)
end

return var_0_0
