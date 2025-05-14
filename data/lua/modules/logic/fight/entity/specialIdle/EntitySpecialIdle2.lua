module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle2", package.seeall)

local var_0_0 = class("EntitySpecialIdle2", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, arg_1_0._onBeginWave, arg_1_0)

	arg_1_0._act_count = 0
	arg_1_0._entity = arg_1_1
end

function var_0_0._onSkillPlayFinish(arg_2_0, arg_2_1)
	if arg_2_1.id ~= arg_2_0._entity.id then
		return
	end

	if not arg_2_0._last_round_id then
		arg_2_0._last_round_id = FightModel.instance:getCurRoundId()
	end

	if FightModel.instance:getCurRoundId() - arg_2_0._last_round_id > 1 then
		arg_2_0._act_count = 0
	else
		arg_2_0._act_count = arg_2_0._act_count + 1
	end

	arg_2_0._last_round_id = FightModel.instance:getCurRoundId()

	if arg_2_0._act_count >= 3 then
		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, arg_2_1.id)

		arg_2_0._act_count = 0
	end
end

function var_0_0._onBeginWave(arg_3_0)
	arg_3_0._act_count = 0
end

function var_0_0.releaseSelf(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_4_0._onSkillPlayFinish, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, arg_4_0._onBeginWave, arg_4_0)

	arg_4_0._entity = nil

	arg_4_0:__onDispose()
end

return var_0_0
