module("modules.logic.fight.system.work.FightWorkClearAiJiAoQteTempData", package.seeall)

local var_0_0 = class("FightWorkClearAiJiAoQteTempData", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	FightDataHelper.tempMgr.aiJiAoFakeHpDic = {}
	FightDataHelper.tempMgr.aiJiAoFakeShieldDic = {}
	FightDataHelper.tempMgr.aiJiAoQteCount = 0
	FightDataHelper.tempMgr.aiJiAoQteEndlessLoop = 0

	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AiJiAoQteIng)
	arg_1_0:onDone(true)
end

return var_0_0
