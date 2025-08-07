module("modules.logic.fight.system.work.FightWorkEzioBigSkillExit1003", package.seeall)

local var_0_0 = class("FightWorkEzioBigSkillExit1003", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if not var_1_0 or not var_1_0.skill then
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = FightStepData.New(FightDef_pb.FightStep())

	var_1_1.isFakeStep = true
	var_1_1.fromId = var_1_0.id
	var_1_1.toId = var_1_0:isMySide() and FightEntityScene.EnemySideId or FightEntityScene.MySideId
	var_1_1.actType = FightEnum.ActType.SKILL

	table.insert(var_1_1.actEffect, arg_1_0.actEffectData)

	local var_1_2 = var_1_0.skill:registTimelineWork("aijiao_312301_unique_direct_exit", var_1_1)

	arg_1_0:playWorkAndDone(var_1_2)
end

return var_0_0
