module("modules.logic.fight.system.work.FightWorkEndGC", package.seeall)

local var_0_0 = class("FightWorkEndGC", BaseWork)

function var_0_0.onStart(arg_1_0)
	FightPreloadController.instance:releaseTimelineRefAsset()
	FightHelper.clearNoUseEffect()
	arg_1_0:onDone(true)
end

return var_0_0
