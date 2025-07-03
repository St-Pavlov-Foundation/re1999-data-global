module("modules.logic.fight.entity.comp.skill.FightTLEventSetFightViewPartVisible", package.seeall)

local var_0_0 = class("FightTLEventSetFightViewPartVisible", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = FightTLHelper.getBoolParam(arg_1_3[1])

	FightViewPartVisible.setWaitAreaActive(var_1_0)
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
