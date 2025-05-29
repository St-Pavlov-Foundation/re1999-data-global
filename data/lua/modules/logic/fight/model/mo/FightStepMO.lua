module("modules.logic.fight.model.mo.FightStepMO", package.seeall)

local var_0_0 = pureTable("FightStepMO")
local var_0_1 = 1

function var_0_0.ctor(arg_1_0)
	arg_1_0.stepUid = var_0_1
	var_0_1 = var_0_1 + 1
	arg_1_0.atkAudioId = nil
	arg_1_0.editorPlaySkill = nil
	arg_1_0.isParallelStep = false
	arg_1_0.cusParam_lockTimelineTypes = nil
	arg_1_0.cus_Param_invokeSpineActTimelineEnd = nil
	arg_1_0.hasPlay = nil
	arg_1_0.custom_stepIndex = nil
	arg_1_0.custom_ingoreParallelSkill = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.actType = arg_2_1.actType
	arg_2_0.fromId = arg_2_1.fromId
	arg_2_0.toId = arg_2_1.toId
	arg_2_0.actId = arg_2_1.actId
	arg_2_0.actEffectMOs = arg_2_0:_buildActEffect(arg_2_1.actEffect, arg_2_2)

	if (not arg_2_0.toId or arg_2_0.toId == "0") and #arg_2_0.actEffectMOs > 0 then
		arg_2_0.toId = arg_2_0.actEffectMOs[1].targetId
	end

	arg_2_0.cardIndex = arg_2_1.cardIndex
	arg_2_0.supportHeroId = arg_2_1.supportHeroId
	arg_2_0.fakeTimeline = arg_2_1.fakeTimeline
end

function var_0_0._buildActEffect(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = FightDataHelper.entityMgr:getById(arg_3_0.fromId)
	local var_3_2 = var_3_1 and var_3_1.side

	if not var_3_1 then
		if arg_3_0.fromId == FightEntityScene.MySideId then
			var_3_2 = FightEnum.EntitySide.MySide
		elseif arg_3_0.fromId == FightEntityScene.EnemySideId then
			var_3_2 = FightEnum.EntitySide.EnemySide
		end
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_3 = false

		if iter_3_1.effectType == FightEnum.EffectType.FIGHTSTEP then
			local var_3_4 = iter_3_1.fightStep

			if var_3_4.fakeTimeline or FightHelper.isTimelineStep(var_3_4) then
				var_3_3 = true
			end
		elseif iter_3_1.effectType == FightEnum.EffectType.ATTR then
			var_3_3 = true
		end

		if arg_3_2 then
			var_3_3 = false
		end

		if not var_3_3 then
			local var_3_5 = FightActEffectMO.New()

			var_3_5:init(iter_3_1, var_3_2)
			table.insert(var_3_0, var_3_5)
		end
	end

	return var_3_0
end

return var_0_0
