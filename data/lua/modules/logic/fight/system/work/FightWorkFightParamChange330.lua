module("modules.logic.fight.system.work.FightWorkFightParamChange330", package.seeall)

local var_0_0 = class("FightWorkFightParamChange330", FightEffectBase)

var_0_0.tempWorkKeyDict = {}

function var_0_0.onStart(arg_1_0)
	arg_1_0.sequenceFlow = arg_1_0:com_registWorkDoneFlowSequence()
	arg_1_0.param = FightDataHelper.fieldMgr.param

	local var_1_0 = GameUtil.splitString2(arg_1_0.actEffectData.reserveStr, true)
	local var_1_1 = var_0_0.tempWorkKeyDict

	tabletool.clear(var_1_1)

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_2 = iter_1_1[1]
		local var_1_3 = iter_1_1[2]
		local var_1_4 = arg_1_0.param[var_1_2]
		local var_1_5 = var_1_4 - var_1_3
		local var_1_6 = var_0_0.Param2WorkKey[var_1_2]

		if not (var_1_6 and var_1_1[var_1_6]) then
			if var_1_6 then
				var_1_1[var_1_6] = true
			end

			local var_1_7 = var_0_0.Key2Work[var_1_2]

			if var_1_7 then
				arg_1_0.sequenceFlow:registWork(var_1_7, var_1_2, var_1_5, var_1_4, var_1_3)
			else
				arg_1_0.sequenceFlow:registWork(FightWorkSendEvent, FightEvent.UpdateFightParam, var_1_2, var_1_5, var_1_4, var_1_3, arg_1_0.actEffectData)
			end
		end
	end

	arg_1_0.sequenceFlow:start()
end

var_0_0.Key2Work = {
	[FightParamData.ParamKey.DoomsdayClock_Value] = FightParamChangeWork3,
	[FightParamData.ParamKey.DoomsdayClock_Range1] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range2] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range3] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range4] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Offset] = FightParamChangeWork4,
	[FightParamData.ParamKey.ACT191_MIN_HP_RATE] = FightParamChangeWork9
}

local var_0_1 = 0

local function var_0_2()
	var_0_1 = var_0_1 + 1

	return var_0_1
end

var_0_0.WorkKey = {
	DoomsDayClockAreaChangeKey = var_0_2()
}
var_0_0.Param2WorkKey = {
	[FightParamData.ParamKey.DoomsdayClock_Range1] = var_0_0.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range2] = var_0_0.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range3] = var_0_0.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range4] = var_0_0.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Offset] = var_0_0.WorkKey.DoomsDayClockAreaChangeKey
}

return var_0_0
