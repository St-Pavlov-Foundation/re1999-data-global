module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle8", package.seeall)

local var_0_0 = class("EntitySpecialIdle8", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnMySideRoundEnd, arg_1_0._onMySideRoundEnd, arg_1_0)

	arg_1_0._act_round = 0
	arg_1_0._round = 0
	arg_1_0._entity = arg_1_1
end

function var_0_0._onSkillPlayFinish(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1.id ~= arg_2_0._entity.id then
		return
	end

	arg_2_0._act_round = FightModel.instance:getCurRoundId()
end

function var_0_0._onMySideRoundEnd(arg_3_0)
	arg_3_0._round = FightModel.instance:getCurRoundId()

	if arg_3_0._round - arg_3_0._act_round > 1 then
		arg_3_0._act_round = arg_3_0._round

		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, arg_3_0._entity.id)
	end
end

function var_0_0.releaseSelf(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_4_0._onSkillPlayFinish, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnMySideRoundEnd, arg_4_0._onMySideRoundEnd, arg_4_0)

	arg_4_0._entity = nil

	arg_4_0:__onDispose()
end

return var_0_0
