﻿module("modules.logic.fight.system.work.FightWorkProgressChange", package.seeall)

local var_0_0 = class("FightWorkProgressChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._oldValue = FightDataHelper.fieldMgr.progress
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_sendMsg(FightMsgId.FightProgressValueChange)

	arg_2_0._maxValue = FightDataHelper.fieldMgr.progressMax

	if arg_2_0._oldValue < arg_2_0._maxValue and FightDataHelper.fieldMgr.progress >= arg_2_0._maxValue then
		arg_2_0:com_registTimer(arg_2_0._delayAfterPerformance, 0.25 / FightModel.instance:getUISpeed())
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
