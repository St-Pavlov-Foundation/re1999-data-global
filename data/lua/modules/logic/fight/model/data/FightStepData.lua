module("modules.logic.fight.model.data.FightStepData", package.seeall)

local var_0_0 = FightDataClass("FightStepData")
local var_0_1 = 1

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0:initClientParam()

	if not arg_1_1 then
		return
	end

	arg_1_0.actType = arg_1_1.actType
	arg_1_0.fromId = arg_1_1.fromId
	arg_1_0.toId = arg_1_1.toId
	arg_1_0.actId = arg_1_1.actId
	arg_1_0.actEffect = arg_1_0:buildActEffect(arg_1_1.actEffect)
	arg_1_0.cardIndex = arg_1_1.cardIndex or 0
	arg_1_0.supportHeroId = arg_1_1.supportHeroId or 0
	arg_1_0.fakeTimeline = arg_1_1.fakeTimeline
end

function var_0_0.initClientParam(arg_2_0)
	arg_2_0.stepUid = var_0_1
	var_0_1 = var_0_1 + 1
	arg_2_0.atkAudioId = nil
	arg_2_0.editorPlaySkill = nil
	arg_2_0.isParallelStep = false
	arg_2_0.cusParam_lockTimelineTypes = nil
	arg_2_0.cus_Param_invokeSpineActTimelineEnd = nil
	arg_2_0.hasPlay = nil
	arg_2_0.custom_stepIndex = nil
	arg_2_0.custom_ingoreParallelSkill = nil
end

function var_0_0.buildActEffect(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_1 = FightActEffectData.New(iter_3_1)

		table.insert(var_3_0, var_3_1)
	end

	return var_3_0
end

return var_0_0
