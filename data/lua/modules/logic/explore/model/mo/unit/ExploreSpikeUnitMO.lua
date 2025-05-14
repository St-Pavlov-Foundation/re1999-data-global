module("modules.logic.explore.model.mo.unit.ExploreSpikeUnitMO", package.seeall)

local var_0_0 = pureTable("ExploreSpikeUnitMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	local var_1_0 = string.split(arg_1_0.specialDatas[1], "#")
	local var_1_1 = string.split(arg_1_0.specialDatas[2], "#")

	arg_1_0.intervalTime = tonumber(var_1_1[1])
	arg_1_0.keepTime = tonumber(var_1_1[2])
	arg_1_0.playAudio = tonumber(var_1_1[3]) == 1
	arg_1_0.enterTriggerType = true
	arg_1_0.heroDir = tonumber(var_1_0[3]) or 0
	arg_1_0.triggerEffects = tabletool.copy(arg_1_0.triggerEffects)

	local var_1_2 = {
		ExploreEnum.TriggerEvent.Spike
	}

	table.insert(arg_1_0.triggerEffects, var_1_2)
end

function var_0_0.getUnitClass(arg_2_0)
	return ExploreSpikeUnit
end

return var_0_0
