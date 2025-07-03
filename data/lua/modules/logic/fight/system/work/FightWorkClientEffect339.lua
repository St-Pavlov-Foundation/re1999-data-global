module("modules.logic.fight.system.work.FightWorkClientEffect339", package.seeall)

local var_0_0 = class("FightWorkClientEffect339", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.effectNum
	local var_1_1 = arg_1_0["clientEffect" .. var_1_0]

	if not var_1_1 then
		if isDebugBuild then
			logError("客户端未处理表现 ： " .. tostring(var_1_0))
		end

		return arg_1_0:onDone(true)
	end

	local var_1_2 = arg_1_0:com_registWorkDoneFlowSequence()

	var_1_2:registWork(Work2FightWork, FunctionWork, var_1_1, arg_1_0)

	local var_1_3 = var_0_0.ClientEffectWaitTime[var_1_0]

	if var_1_3 then
		var_1_2:registWork(Work2FightWork, TimerWork, var_1_3)
	end

	var_1_2:start()
end

function var_0_0.clientEffect1(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnBroken)
end

function var_0_0.clientEffect2(arg_3_0)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnClear)
end

var_0_0.ClientEffectEnum = {
	DoomsdayClock = 1,
	DoomsdayClockClear = 2
}
var_0_0.ClientEffectWaitTime = {
	[var_0_0.ClientEffectEnum.DoomsdayClock] = 0.5,
	[var_0_0.ClientEffectEnum.DoomsdayClockClear] = 0.2
}

return var_0_0
