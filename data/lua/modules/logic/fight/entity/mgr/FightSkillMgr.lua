module("modules.logic.fight.entity.mgr.FightSkillMgr", package.seeall)

local var_0_0 = class("FightSkillMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._playingEntityId2StepData = {}
	arg_1_0._playingSkillCount = 0
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.dispose(arg_3_0)
	arg_3_0._playingEntityId2StepData = {}
	arg_3_0._playingSkillCount = 0
end

function var_0_0.beforeTimeline(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._playingSkillCount = arg_4_0._playingSkillCount + 1
	arg_4_0._playingEntityId2StepData[arg_4_1.id] = arg_4_2 or 1

	arg_4_1:resetEntity()
	FightController.instance:dispatchEvent(FightEvent.BeforePlayTimeline, arg_4_1.id)

	if FightCardDataHelper.isBigSkill(arg_4_2.actId) then
		FightController.instance:dispatchEvent(FightEvent.BeforePlayUniqueSkill, arg_4_1.id)
	end
end

function var_0_0.afterTimeline(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._playingSkillCount = arg_5_0._playingSkillCount - 1

	if arg_5_0._playingSkillCount < 0 then
		arg_5_0._playingSkillCount = 0
	end

	arg_5_0._playingEntityId2StepData[arg_5_1.id] = nil

	if arg_5_2 and FightCardDataHelper.isBigSkill(arg_5_2.actId) then
		FightController.instance:dispatchEvent(FightEvent.AfterPlayUniqueSkill, arg_5_1.id)

		local var_5_0 = FightHelper.getAllEntitys()

		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			iter_5_1:resetEntity()
		end
	else
		arg_5_1:resetEntity()
	end

	if not arg_5_0:isPlayingAnyTimeline() then
		FightTLEventUIVisible.resetLatestStepUid()
	end
end

function var_0_0.isEntityPlayingTimeline(arg_6_0, arg_6_1)
	return arg_6_0._playingEntityId2StepData[arg_6_1] ~= nil
end

function var_0_0.isPlayingAnyTimeline(arg_7_0)
	return arg_7_0._playingSkillCount > 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
