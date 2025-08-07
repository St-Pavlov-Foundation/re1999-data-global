module("modules.logic.fight.system.work.FightWorkEzioBigSkillDamage1000", package.seeall)

local var_0_0 = class("FightWorkEzioBigSkillDamage1000", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:onDone(true)
end

function var_0_0.fakeDecreaseHp(arg_2_0, arg_2_1)
	local var_2_0 = FightDataHelper.entityMgr:getById(arg_2_0)

	if not var_2_0 then
		return
	end

	local var_2_1 = (FightDataHelper.tempMgr.aiJiAoFakeHpOffset[var_2_0.id] or 0) + arg_2_1

	FightDataHelper.tempMgr.aiJiAoFakeHpOffset[var_2_0.id] = var_2_1
end

function var_0_0.calFakeHpAndShield(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = FightDataHelper.tempMgr.aiJiAoFakeHpOffset[arg_3_0]

	if var_3_0 then
		if arg_3_2 > 0 then
			if var_3_0 <= arg_3_2 then
				arg_3_2 = arg_3_2 - var_3_0
				var_3_0 = 0
			else
				var_3_0 = var_3_0 - arg_3_2
				arg_3_2 = 0
			end
		end

		arg_3_1 = arg_3_1 - var_3_0

		local var_3_1 = 0
	end

	return arg_3_1, arg_3_2
end

return var_0_0
