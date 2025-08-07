module("modules.logic.fight.entity.comp.skill.FightTLEventEffectVisible", package.seeall)

local var_0_0 = class("FightTLEventEffectVisible", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_3[1]

	arg_1_0:com_sendFightEvent(FightEvent.SetMagicCircleVisible, var_1_0 == "1", "FightTLEventEffectVisible")

	local var_1_1 = arg_1_3[2]

	arg_1_0:com_sendFightEvent(FightEvent.SetLiangYueEffectVisible, var_1_1 == "1")

	local var_1_2 = arg_1_3[3]

	arg_1_0:com_sendFightEvent(FightEvent.SetBuffTypeIdSceneEffect, var_1_2 == "1")
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
