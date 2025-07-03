module("modules.logic.fight.system.work.FightGuideBeforeSkill", package.seeall)

local var_0_0 = class("FightGuideBeforeSkill", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_0.fightStepData.fromId == FightEntityScene.MySideId or arg_2_0.fightStepData.fromId == FightEntityScene.EnemySideId then
		arg_2_0:_done()

		return
	end

	arg_2_0._attacker = FightHelper.getEntity(arg_2_0.fightStepData.fromId)
	arg_2_0._skillId = arg_2_0.fightStepData.actId

	if arg_2_0._attacker == nil then
		arg_2_0:_done()

		return
	end

	local var_2_0 = FightController.instance:GuideFlowPauseAndContinue("OnGuideBeforeSkillPause", FightEvent.OnGuideBeforeSkillPause, FightEvent.OnGuideBeforeSkillContinue, arg_2_0._done, arg_2_0, arg_2_0._attacker:getMO().modelId, arg_2_0._skillId)
end

function var_0_0._done(arg_3_0)
	arg_3_0:onDone(true)
end

return var_0_0
